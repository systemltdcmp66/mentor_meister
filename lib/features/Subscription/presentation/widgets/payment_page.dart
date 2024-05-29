import 'package:mentormeister/features/Subscription/presentation/widgets/add_card_detail_page.dart';
import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import '../../../../commons/widgets/custom_appbar.dart';
import '../../../../commons/widgets/custom_button.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool isCardSelected = false;
  String? selectedCardName;
  String? selectedCardImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryBGColor,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
        child: const Center(
          child: CustomAppBar(title: 'Payment Method'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.paddingSize),
        child: Column(
          children: [
            buildGestureDetector(
                'assets/subscription/mastercard.png', 'DebitCard'),
            SizedBox(height: Dimensions.heightSize),
            buildGestureDetector('assets/subscription/paypal.png', 'Poyneer'),
            SizedBox(height: Dimensions.heightSize),
            buildGestureDetector(
                'assets/subscription/apple_pay.png', 'Apple Pay'),
            const Spacer(),
            CustomButton(
                text: 'Proceed to Payment',
                onPressed: () {
                  setState(() {
                    isCardSelected = true;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddCardDetailPage(
                        selectedCardName: selectedCardName,
                        selectedCardImage: selectedCardImage,
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  GestureDetector buildGestureDetector(String imagePath, String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCardName = text;
          selectedCardImage = imagePath;
        });
      },
      child: Container(
        height: 80.h,
        padding: EdgeInsets.only(left: 10.r),
        decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
          border: Border.all(
              color: selectedCardName == text
                  ? CustomColor.redColor
                  : Colors.transparent),
        ),
        child: Row(
          children: [
            Image(image: AssetImage(imagePath), height: 40.h, width: 40.w),
            SizedBox(width: Dimensions.widthSize),
            Text(
              text,
              style: CustomStyle.interh2,
            ),
          ],
        ),
      ),
    );
  }
}
