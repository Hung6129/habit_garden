// Importing the necessary part of the BLoC file to keep the code organized
part of '../bloc/authenticate_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static openFromWalkThrough(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInPage(),
      ),
    );
  }

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isRememberMe = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => iS<AuthenticateBloc>(),
      child: BlocConsumer<AuthenticateBloc, AuthenticateState>(
        // BlocConsumer listens to state changes and rebuilds the UI accordingly
        // A cleaner way to handle listener is to shove it into a static method in the bloc =))
        listener: AuthenticateBloc.onListenerHandleSigninState,
        builder: (context, state) => AppMainWidget(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSignInForm(context, state),
            ],
          ),
        ),
      ),
    );
  }

  FormBuilder _buildSignInForm(
    BuildContext context,
    AuthenticateState state,
  ) {
    return FormBuilder(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            FormUtils.renderInputField(
              context,
              key: 'email',
              label: 'Email',
              hintText: 'Enter your email',
              require: true,
              validator: (value) => ValidatorUtil.requireValidator(value),
              onChanged: (value) {},
            ),
            SizedBox(height: AppUIConstants.majorScaleMargin(4)),
            FormUtils.renderPasswordField(
              context,
              require: true,
              label: 'Password',
              key: 'password',
              validator: (value) => ValidatorUtil.requireValidator(value),
              hintText: 'Enter your password',
              onChanged: (value) {},
            ),
            SizedBox(height: AppUIConstants.majorScaleMargin(8)),
            AppTextCheckBoxWidget(
              value: _isRememberMe,
              child: AppTextWidget(
                'Remember me',
                textStyle: Theme.of(context).textTheme.bodySmall,
              ),
              onChanged: (value) {
                setState(() {
                  _isRememberMe = value;
                });
              },
            ),
            SizedBox(height: AppUIConstants.majorScaleMargin(8)),
            AppFilledButtonWidget(
              'Sign In',
              onPressed: () {
                if (_formKey.currentState!.saveAndValidate()) {
                  final data = _formKey.currentState!.value;
                  context.read<AuthenticateBloc>().add(
                        SignInWithEmailAndPassword(
                          signInParam: SignInParam(
                            email: data['email'],
                            password: data['password'],
                          ),
                          isRememberMe: _isRememberMe,
                        ),
                      );
                }
              },
            ),
            SizedBox(height: AppUIConstants.majorScaleMargin(8)),
            AppOutlinedButtonWidget(
              'Sign up',
              onPressed: () => SignupPage.openFromSignin(context),
            ),
          ],
        ),
      ),
    );
  }
}
