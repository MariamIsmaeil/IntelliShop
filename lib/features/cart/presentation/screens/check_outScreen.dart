import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/features/cart/domain/usecase/cancel_order_usecase.dart';
import 'package:ecommerce_app/features/cart/domain/usecase/checkout_usecase.dart';
import 'package:ecommerce_app/features/cart/domain/usecase/get_order_by_id_usecase.dart';
import 'package:ecommerce_app/features/cart/domain/usecase/get_orders_usecase.dart';
import 'package:ecommerce_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:ecommerce_app/features/cart/presentation/manager/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  final double total;
  const CheckoutScreen({super.key, required this.total});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String? firstName, lastName, email, phone, addressOne, addressTwo, postalCode;
  String paymentMethod = 'Cash';

  void _submitOrder() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final orderCubit = BlocProvider.of<OrderCubit>(context);
      final cartCubit = BlocProvider.of<CartCubit>(context);

      await orderCubit.checkout(
        firstName: firstName!,
        lastName: lastName!,
        email: email!,
        phoneNumber: phone!,
        addressOne: addressOne!,
        addressTwo: addressTwo ?? '',
        postalCode: postalCode!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final shipping = 50;
    final totalWithShipping = widget.total + shipping;

    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is OrderCheckoutSuccess) {
          final cartCubit = BlocProvider.of<CartCubit>(context);
          cartCubit.deleteCart();
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.mainRoute,
            (route) => false,
          );

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Your order has been placed successfully!'),
            ),
          );
        } else if (state is OrderError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Checkout failed: ${state.message}'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Checkout',
              style: TextStyle(color: ColorManager.appBarTitleColor)),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildSectionCard(
                  title: 'Customer Info',
                  children: [
                    _buildTextField(
                      label: 'First Name',
                      onSaved: (v) => firstName = v,
                    ),
                    _buildTextField(
                      label: 'Last Name',
                      onSaved: (v) => lastName = v,
                    ),
                    _buildTextField(
                      label: 'Email',
                      onSaved: (v) => email = v,
                      inputType: TextInputType.emailAddress,
                    ),
                    _buildTextField(
                      label: 'Phone Number',
                      onSaved: (v) => phone = v,
                      inputType: TextInputType.phone,
                    ),
                    _buildTextField(
                      label: 'Address Line 1',
                      onSaved: (v) => addressOne = v,
                      maxLines: 2,
                    ),
                    _buildTextField(
                      label: 'Address Line 2 (Optional)',
                      onSaved: (v) => addressTwo = v,
                      maxLines: 2,
                      isRequired: false,
                    ),
                    _buildTextField(
                      label: 'Postal Code',
                      onSaved: (v) => postalCode = v,
                      inputType: TextInputType.number,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSectionCard(
                  title: 'Payment Method',
                  children: [
                    Row(
                      children: ['Cash', 'Visa'].map((method) {
                        return Expanded(
                          child: RadioListTile<String>(
                            value: method,
                            groupValue: paymentMethod,
                            onChanged: (value) {
                              setState(() {
                                paymentMethod = value!;
                              });
                            },
                            title: Text(method),
                            activeColor: ColorManager.appBarTitleColor,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 4),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSectionCard(
                  title: 'Order Summary',
                  children: [
                    _buildSummaryRow('Subtotal', '${widget.total.toInt()} EGP'),
                    _buildSummaryRow('Shipping', '$shipping EGP'),
                    const Divider(thickness: 1),
                    _buildSummaryRow(
                      'Total',
                      '${totalWithShipping.toInt()} EGP',
                      isBold: true,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                BlocBuilder<OrderCubit, OrderState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state is OrderLoading ? null : _submitOrder,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.appBarTitleColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: state is OrderLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text('Confirm Order',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required FormFieldSetter<String> onSaved,
    TextInputType inputType = TextInputType.text,
    int maxLines = 1,
    bool isRequired = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        onSaved: onSaved,
        keyboardType: inputType,
        maxLines: maxLines,
        validator: isRequired
            ? (value) => value!.isEmpty ? 'Please enter $label' : null
            : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorManager.appBarTitleColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorManager.appBarTitleColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: ColorManager.appBarTitleColor, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required List<Widget> children,
    required String title,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.primary, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorManager.primary,
                fontSize: 16,
              )),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: ColorManager.appBarTitleColor,
                  fontSize: 14,
                  fontWeight: isBold ? FontWeight.bold : null)),
          Text(value,
              style: TextStyle(
                  color: ColorManager.appBarTitleColor,
                  fontSize: 14,
                  fontWeight: isBold ? FontWeight.bold : null)),
        ],
      ),
    );
  }
}
