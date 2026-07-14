import 'package:shelf_router/shelf_router.dart';
import '../controllers/register_page_controller.dart';


class RegisterPageUpdate {

  final RegisterPageController controller = RegisterPageController();



Router get router {


final router = Router();



router.post(
"/admin/page/save-register-page",
controller.saveRegisterPage
);



router.get(
"/admin/page/get-register-page",
controller.getRegisterPage
);



return router;

}


}