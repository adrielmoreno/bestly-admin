import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/common/buttons/custom_outlined_button.dart';
import '../../../../core/presentation/common/buttons/link_text.dart';
import '../../../../core/presentation/common/inputs/custom_inputs.dart';
import '../../../../core/presentation/common/theme/constants/app_dimens.dart';
import '../providers/login_form_provider.dart';
import 'register_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const String route = 'login';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),
      child: Builder(builder: (context) {
        final loginFormProvider =
            Provider.of<LoginFormProvider>(context, listen: false);
        return Container(
          margin: const EdgeInsets.only(top: AppDimens.semiHuge),
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.semiBig),
          child: Center(
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: AppDimens.maxFormWidth),
              child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: loginFormProvider.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Email
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          // TODO: Add error controll
                          controller: loginFormProvider.email,

                          validator: (value) {
                            if (!EmailValidator.validate('${value?.trim()}')) {
                              return 'Email no válido';
                            }

                            return null;
                          },

                          onFieldSubmitted: (_) =>
                              loginFormProvider.validateForm(),
                          style: const TextStyle(color: Colors.white),
                          decoration: CustomInputs.loginInputDecoration(
                              hint: 'Ingrese su correo',
                              label: 'Email',
                              icon: Icons.email_outlined),
                        ),

                        const SizedBox(height: AppDimens.medium),

                        // Password
                        TextFormField(
                          controller: loginFormProvider.password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese su contraseña';
                            }

                            if (value.length < 6) {
                              return 'La contraseña debe de ser de 6 caractares';
                            }

                            return null;
                          },
                          onFieldSubmitted: (_) =>
                              loginFormProvider.validateForm(),
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          style: const TextStyle(color: Colors.white),
                          decoration: CustomInputs.loginInputDecoration(
                              hint: '*********',
                              label: 'Contraseña',
                              icon: Icons.lock_outline_rounded),
                        ),

                        const SizedBox(height: AppDimens.medium),
                        CustomOutlinedButton(
                          onPressed: () {
                            loginFormProvider.validateForm();
                          },
                          text: 'Ingresar',
                        ),

                        const SizedBox(height: AppDimens.medium),
                        LinkText(
                          text: 'Nueva cuenta',
                          onPressed: () {
                            context.goNamed(RegisterView.route,
                                extra: {const RegisterView()});
                          },
                        )
                      ],
                    ),
                  )),
            ),
          ),
        );
      }),
    );
  }
}
