import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../controllers/login_page_controller.dart';

class LoginPageUpdate{
  Router get router{
    final router = Router();
    router.post('/admin/page/save-login-page',saveLoginPage);
    router.get('/admin/page/get-login-page',getLoginPage);
  return router;
  }
}