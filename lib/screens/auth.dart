import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
   final _formkey = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  final _isAuthentication = false;

  void _submit () async {
 final isValid = _formkey.currentState!.validate();
 if (!isValid){
  return;
 }
 _formkey.currentState!.save();
 try{
  if(_isLogin){
    final UserCredential = await _firebase.signInWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);
    print(UserCredential);
  } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        print(userCredentials);
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        // ...
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed.'),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color(0xFF1C1919),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 20),
                width: 330,
                child: Image.asset( 'assets/image/applogo.png'),
              ),
                Card(
                  color:   const Color(0xFF1C1919),
                   margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    //declare the formkey in your form widget to hold all inputed values
                    key: _formkey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                     TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Email Address',
                                 labelStyle: TextStyle(color:Colors.white), 
                                 prefixIcon: Icon(Icons.email_sharp,color: Colors.white),
                             prefixStyle: TextStyle(color: Colors.white,), ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                          TextFormField(
                             style: const TextStyle(color: Colors.white),
                            decoration:
                                const InputDecoration(labelText: 'Password', labelStyle: TextStyle(color:Colors.white), 
                                 prefixIcon: Icon(Icons.lock,color: Colors.white),
                             prefixStyle: TextStyle(color: Colors.white,),),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password must be at least 6 characters long.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!;
                            },
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[400]
                            ),
                            child: Text(_isLogin ? 'Login' : 'Signup'),
                          ),
                          TextButton(
                         style: TextButton.styleFrom(
                      foregroundColor: Colors.grey[400], 
                    //  surfaceTintColor:Colors.grey[400], 
  ),
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                        
                            },
                            child: Text(_isLogin
                                ? 'Create an account'
                                : 'I already have an account',
                              //  selectionColor: Colors.grey[400]
                                ),
                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
