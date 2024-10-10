part of '../bloc/authenticate_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static openFromSignin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignupPage(),
      ),
    );
  }

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => iS<AuthenticateBloc>(),
      child: BlocConsumer<AuthenticateBloc, AuthenticateState>(
        listener: AuthenticateBloc.onListenerHandleSignupState,
        builder: (context, state) => AppMainWidget(
          appBarWidget: const AppBarWidget(text: 'Sign Up'),
          body: Column(
            children: [
              _buildSignUnForm(context),
            ],
          ),
        ),
      ),
    );
  }

  FormBuilder _buildSignUnForm(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormUtils.renderInputField(
              context,
              key: 'name',
              label: 'Name',
              hintText: 'Enter your name',
              require: true,
              validator: (value) => ValidatorUtil.requireValidator(value),
              onChanged: (value) {},
            ),
            SizedBox(height: AppUIConstants.majorScaleMargin(4)),
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
            AppFilledButtonWidget(
              'Sign Up',
              onPressed: () {
                if (_formKey.currentState!.saveAndValidate()) {
                  final data = _formKey.currentState!.value;
                  context.read<AuthenticateBloc>().add(
                        SignUpWithEmailAndPassword(
                          signUpParam: SignUpParam(
                            username: data['name'],
                            email: data['email'],
                            password: data['password'],
                          ),
                        ),
                      );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
