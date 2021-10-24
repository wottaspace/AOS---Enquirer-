import 'package:arcopen_enquirer/config/routes/k_router.dart';
import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/http/requests/job_request.dart';
import 'package:arcopen_enquirer/utils/repositories/jobs_repository.dart';
import 'package:arcopen_enquirer/utils/services/auth_service.dart';
import 'package:arcopen_enquirer/widgets/dialogs/k_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:okito/okito.dart';

class CreateJobController extends BaseController {
  CreateJobController._internal();
  static final CreateJobController _singleton = CreateJobController._internal();

  factory CreateJobController() {
    return _singleton;
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isDraft = false;
  late String jobCategory;
  late String shiftType;
  late String jobType;
  late String city = Okito.use<AuthService>().profile.city!;
  late String fileName = "";
  late String? contract;

  final TextEditingController budgetController = TextEditingController();
  final TextEditingController emergencyRateController = TextEditingController();
  final TextEditingController businessController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController vacanciesCountController =
      TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController contractController = TextEditingController();

  final JobsRepository _repository = JobsRepository();

  saveJob() {
    KLoader().show();
    _repository
        .createJob(
      request: JobRequest(
          address: addressController.text,
          budget: budgetController.text,
          businessName: businessController.text,
          city: city,
          contract: contract ?? contractController.text,
          fileName: fileName,
          emergencyRate: emergencyRateController.text,
          isDraft: isDraft.toString(),
          jobCategory: jobCategory,
          jobDescription: descriptionController.text,
          jobType: jobType,
          shiftEndDate: endDateController.text,
          shiftEndTime: endTimeController.text,
          shiftStartDate: startDateController.text,
          shiftStartTime: startTimeController.text,
          shiftType: shiftType,
          vacancies: vacanciesCountController.text),
    )
        .then((value) {
      this.showSuccessToast("Job created successfully!");
      KLoader.hide();
      KRouter().pop();
    }).catchError((e) {
      KLoader.hide();
      this.showErrorToast(e.message);
    });
  }

  loadMembers() {}
}
