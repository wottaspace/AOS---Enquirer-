import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/core/models/plan.dart';
import 'package:arcopen_enquirer/utils/helpers/loading_state.dart';
import 'package:arcopen_enquirer/utils/mixins/logging_mixin.dart';
import 'package:arcopen_enquirer/utils/mixins/toast_mixin.dart';
import 'package:arcopen_enquirer/utils/repositories/subscriptions_repository.dart';
import 'package:arcopen_enquirer/utils/services/subscription_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';
import 'package:purchases_flutter/object_wrappers.dart';

class SubscriptionController extends BaseController with ToastMixin, LoggingMixin {
  static final SubscriptionController shared = SubscriptionController();
  final SubscriptionsRepository repository = SubscriptionsRepository();

  List<Plan> subscriptionPlans = [];
  Plan? activePlan;
  LoadingState state = LoadingState.loading;

  Future<void> loadData() async {
    await getSubscriptionPlans();
    await Okito.use<SubscriptionService>().init();

    getActivePlan();
  }

  Future<void> getSubscriptionPlans() async {
    setState(() {
      state = LoadingState.loading;
    });
    await repository.getSubscriptionPlans().then((value) {
      setState(() {
        state = LoadingState.success;
        subscriptionPlans = [...value.freePlans, ...value.employerPlans];
      });
    }).catchError((e) {
      setState(() {
        state = LoadingState.failed;
      });
      this.showErrorToast("Sorry, we are not able to load the data. Please try again later.");
    });
  }

  void getActivePlan() {
    repository.getActivePlan().then((value) {
      if (value.subscription.isNotEmpty) {
        this.activePlan = subscriptionPlans.firstWhere(
          ((element) => element.name == value.subscription.first.paymentStatus),
          orElse: () => this.subscriptionPlans.first,
        );
      }
    }).catchError((e) {
      logger.e(e.message, e);
    });
  }

  upgradePlan(Plan plan) async {
    final duration = await _getDuration();
    if (duration == null) {
      showErrorToast("You need to choose a duration first.");
      return;
    }

    late final String period;
    switch (duration) {
      case PackageType.monthly:
        period = "monthly";
        break;
      case PackageType.annual:
        period = "yearly";
        break;
      default:
        period = "monthly";
        break;
    }
    String planId;
    if (!plan.name.toLowerCase().contains("gold")) {
      planId = "enquirer_${period}_plan";
    } else {
      planId = "gold_enquirer_${period}_plan";
    }
    if (planId == "gold_enquirer_monthly_plan") {
      planId = "gold_enquirer_monthly";
    }
    if (planId == "enquirer_monthly_plan") {
      planId = "enquirer_monthly_subscription";
    }

    Okito.use<SubscriptionService>().purchaseItem(planId, duration);
  }

  Future<PackageType?> _getDuration() {
    return showModalBottomSheet(
      context: Okito.context!,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              "Choose a billing cycle",
              style: Okito.theme.textTheme.headline2!.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(PhosphorIcons.circle_bold),
              title: Text("Month"),
              onTap: () {
                Okito.pop(result: PackageType.monthly);
              },
            ),
            ListTile(
              leading: Icon(PhosphorIcons.circle_bold),
              title: Text("Year"),
              onTap: () {
                Okito.pop(result: PackageType.annual);
              },
            ),
          ],
        );
      },
    );
  }
}
