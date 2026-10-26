import 'package:flutter/material.dart';
import 'package:marci_metzger_homes/home/sections/contact/widgets/contact_field.dart';
import 'package:marci_metzger_homes/shared/navigation/open_site_url.dart';
import 'package:marci_metzger_homes/shared/theme/app_colors.dart';
import 'package:marci_metzger_homes/shared/widgets/site_button.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    return value == null || value.trim().isEmpty
        ? 'Please enter your name.'
        : null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email.';
    }
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value.trim())) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? _validateMessage(String? value) {
    return value == null || value.trim().isEmpty
        ? 'Please tell Marci a little about your plans.'
        : null;
  }

  void _composeEmail() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final body =
        'Hello Marci,\n\n${_message.text.trim()}\n\n'
        'Name: ${_name.text.trim()}\nEmail: ${_email.text.trim()}';
    final uri = Uri(
      scheme: 'mailto',
      path: 'marcimetzger@gmail.com',
      query:
          'subject=${Uri.encodeComponent('Let’s talk about my next move')}'
          '&body=${Uri.encodeComponent(body)}',
    );
    openSiteUrl(context, uri);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: .8)),
        boxShadow: [
          BoxShadow(
            color: AppColors.forest.withValues(alpha: .06),
            blurRadius: 40,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: AutofillGroup(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Tell me what’s next.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                'A personal conversation starts here.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              ContactField(
                label: 'Name',
                child: TextFormField(
                  controller: _name,
                  autofillHints: const [AutofillHints.name],
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 16, color: AppColors.ink),
                  decoration: const InputDecoration(
                    hintText: 'Your name',
                    errorMaxLines: 3,
                  ),
                  validator: _validateName,
                ),
              ),
              const SizedBox(height: 24),
              ContactField(
                label: 'Email',
                child: TextFormField(
                  controller: _email,
                  autofillHints: const [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  enableSuggestions: false,
                  style: const TextStyle(fontSize: 16, color: AppColors.ink),
                  decoration: const InputDecoration(
                    hintText: 'you@example.com',
                    errorMaxLines: 3,
                  ),
                  validator: _validateEmail,
                ),
              ),
              const SizedBox(height: 24),
              ContactField(
                label: 'Message',
                child: TextFormField(
                  controller: _message,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.newline,
                  minLines: 4,
                  maxLines: 8,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: AppColors.ink,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'What does your next chapter look like?',
                    alignLabelWithHint: true,
                    errorMaxLines: 3,
                  ),
                  validator: _validateMessage,
                ),
              ),
              const SizedBox(height: 24),
              SiteButton(
                label: 'Email Marci',
                onPressed: _composeEmail,
                icon: Icons.mail_outline,
                expand: true,
              ),
              const SizedBox(height: 24),
              Text(
                'This opens your email app with your message. Review and send '
                'it there when you’re ready. No message is stored on this website.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'No email app? Copy the address below:',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              const SelectableText(
                'marcimetzger@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: AppColors.forest,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
