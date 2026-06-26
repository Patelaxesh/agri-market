
import 'package:flutter/material.dart';

class PaymentMethodsCard extends StatefulWidget {
  final String initialSelection;
  final Color primaryColor;
  final ValueChanged<String> onPaymentChanged;

  const PaymentMethodsCard({
    super.key,
    required this.initialSelection,
    required this.primaryColor,
    required this.onPaymentChanged,
  });

  @override
  State<PaymentMethodsCard> createState() => _PaymentMethodsCardState();
}

class _PaymentMethodsCardState extends State<PaymentMethodsCard> {
  late String _currentSelection;

  @override
  void initState() {
    super.initState();
    _currentSelection = widget.initialSelection;
  }

  // Modern Payment Option List Tile Builder Component
  Widget _paymentTile({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = _currentSelection == title;

    return InkWell(
      splashColor: widget.primaryColor.withValues(alpha: 0.05),
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        setState(() => _currentSelection = title);
        widget.onPaymentChanged(title);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? widget.primaryColor : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: widget.primaryColor.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: isSelected
                    ? widget.primaryColor.withValues(alpha: 0.1)
                    : const Color(0xFFEDF2F7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? widget.primaryColor
                    : const Color(0xFF64748B),
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w600,
                      color: isSelected
                          ? const Color(0xFF1E293B)
                          : const Color(0xFF475569),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected
                          ? widget.primaryColor.withValues(alpha: 0.8)
                          : const Color(0xFF94A3B8),
                      fontWeight: isSelected
                          ? FontWeight.w500
                          : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Transform.scale(
              scale: 0.95,
              child: Radio<String>(
                value: title,
                activeColor: widget.primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                // groupValue and onChanged are removed here as RadioGroup handles them
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Shared modern decorator configuration for embedded textual inputs
  InputDecoration _customInputDecoration({
    required String hintText,
    String? labelText,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon,
      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
      labelStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
      floatingLabelStyle: TextStyle(
        color: widget.primaryColor,
        fontWeight: FontWeight.w600,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: widget.primaryColor, width: 1.5),
      ),
    );
  }

  // --- Dynamic Form Section Layout Refactoring ---

  Widget _buildUpiFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'UPI ID Setup',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: _customInputDecoration(
            hintText: 'example@upi',
            prefixIcon: const Icon(
              Icons.qr_code_scanner_rounded,
              size: 20,
              color: Color(0xFF64748B),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Card Details',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          keyboardType: TextInputType.number,
          decoration: _customInputDecoration(
            hintText: '0000 0000 0000 0000',
            labelText: 'Card Number',
            prefixIcon: const Icon(
              Icons.credit_card_rounded,
              size: 20,
              color: Color(0xFF64748B),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          textCapitalization: TextCapitalization.characters,
          decoration: _customInputDecoration(
            hintText: 'John Doe',
            labelText: 'Card Holder Name',
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: _customInputDecoration(
                  hintText: 'MM/YY',
                  labelText: 'Expiry Date',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: _customInputDecoration(
                  hintText: '123',
                  labelText: 'CVV',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNetBankingFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popular Banks',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF64748B),
          ),
          decoration: _customInputDecoration(
            hintText: 'Choose your bank Account',
            labelText: 'Select Bank',
          ),
          items: const [
            DropdownMenuItem(
              value: 'SBI',
              child: Text(
                'State Bank of India (SBI)',
                style: TextStyle(color: Color(0xFF1E293B)),
              ),
            ),
            DropdownMenuItem(
              value: 'HDFC',
              child: Text(
                'HDFC Bank',
                style: TextStyle(color: Color(0xFF1E293B)),
              ),
            ),
            DropdownMenuItem(
              value: 'ICICI',
              child: Text(
                'ICICI Bank',
                style: TextStyle(color: Color(0xFF1E293B)),
              ),
            ),
            DropdownMenuItem(
              value: 'Axis',
              child: Text(
                'Axis Bank',
                style: TextStyle(color: Color(0xFF1E293B)),
              ),
            ),
          ],
          onChanged: (_) {},
        ),
      ],
    );
  }

  Widget _buildCodInfo() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: widget.primaryColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: widget.primaryColor.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.verified_user_rounded,
            color: widget.primaryColor,
            size: 20,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Pay when your order is delivered safely. Cash, online UPI tokens, and digital cards are securely accepted on arrival.',
              style: TextStyle(
                color: Color(0xFF334155),
                fontSize: 13,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      // Wrapped layout inside the updated structural RadioGroup pattern
      child: RadioGroup<String>(
        groupValue: _currentSelection,
        onChanged: (value) {
          if (value != null) {
            setState(() => _currentSelection = value);
            widget.onPaymentChanged(value);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: widget.primaryColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.account_balance_wallet_rounded,
                    color: widget.primaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Payment Method',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E293B),
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            _paymentTile(
              title: 'UPI',
              subtitle: 'Google Pay, PhonePe, Paytm',
              icon: Icons.qr_code_rounded,
            ),
            const SizedBox(height: 10),
            _paymentTile(
              title: 'Debit / Credit Card',
              subtitle: 'Visa, Mastercard, RuPay',
              icon: Icons.credit_card_rounded,
            ),
            const SizedBox(height: 10),
            _paymentTile(
              title: 'Net Banking',
              subtitle: 'Pay directly from bank account',
              icon: Icons.account_balance_rounded,
            ),
            const SizedBox(height: 10),
            _paymentTile(
              title: 'Cash on Delivery',
              subtitle: 'Pay when order is delivered',
              icon: Icons.delivery_dining_rounded,
            ),

            if (_currentSelection == 'UPI') ...[
              const SizedBox(height: 20),
              _buildUpiFields(),
            ] else if (_currentSelection == 'Debit / Credit Card') ...[
              const SizedBox(height: 20),
              _buildCardFields(),
            ] else if (_currentSelection == 'Net Banking') ...[
              const SizedBox(height: 20),
              _buildNetBankingFields(),
            ] else if (_currentSelection == 'Cash on Delivery') ...[
              const SizedBox(height: 20),
              _buildCodInfo(),
            ],
          ],
        ),
      ),
    );
  }
}

