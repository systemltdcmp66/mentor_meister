import 'package:mentormeister/core/utils/basic_screen_imports.dart';
import 'package:mentormeister/commons/widgets/custom_button.dart';
import '../../commons/widgets/custom_appbar.dart';

class AddCardDetailPage extends StatefulWidget {
  final String? selectedCardName;
  final String? selectedCardImage;

  const AddCardDetailPage({
    Key? key,
    required this.selectedCardName,
    required this.selectedCardImage,
  }) : super(key: key);

  @override
  State<AddCardDetailPage> createState() => _AddCardDetailPageState();
}

class _AddCardDetailPageState extends State<AddCardDetailPage> {
  bool isCardSave = false;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.selectedCardName ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Dimensions.heightSize),
              buildCard(),
              Visibility(
                visible: !isCardSave,
                child: Card(
                  elevation: 0,
                  child: Column(
                    children: [
                      rowWidget('Card Number', '1234 4564 234 334'),
                      rowWidget2('Expiry Date', '03/12'),
                      rowWidget2('Name on card', 'John'),
                      rowWidget2('Cvv', '009'),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isCardSave,
                child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.all(15.r),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: mainSpaceBet,
                          children: [
                            Text(
                              'Total Amount',
                              style: CustomStyle.interh3,
                            ),
                            Text(
                              '\$30',
                              style: CustomStyle.interh3,
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
              isCardSave
                  ? SizedBox(
                      height: 200.h,
                    )
                  : const SizedBox(),
              CustomButton(
                  text: isCardSave ? 'Pay Now' : 'Save Card',
                  onPressed: () {
                    setState(() {
                      isCardSave = true;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowWidget(String label, String hintText) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(5.r),
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            Text(
              label,
              style: CustomStyle.interh3,
            ),
            SizedBox(
              height: Dimensions.heightSize,
            ),
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                      ),
                    ),
                  ),
                  Image.asset(
                    widget.selectedCardImage ?? '',
                    height: 50,
                    width: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowWidget2(String label, String hintText) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(5.r),
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            Text(
              label,
              style: CustomStyle.interh3,
            ),
            SizedBox(
              height: Dimensions.heightSize,
            ),
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card buildCard() {
    return Card(
      color: CustomColor.redColor,
      child: Padding(
        padding: EdgeInsets.all(Dimensions.paddingSize),
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            Row(
              mainAxisAlignment: mainSpaceBet,
              children: [
                Image.asset(
                  widget.selectedCardImage ?? '',
                  height: 50.h,
                  width: 50.w,
                ),
                const Icon(
                  Icons.select_all,
                  color: CustomColor.whiteColor,
                ),
              ],
            ),
            Text(
              'John',
              style: CustomStyle.whiteh2,
            ),
            Text(
              '3560   8896   6543   2212',
              style: CustomStyle.whiteh2,
            ),
            Row(
              mainAxisAlignment: mainSpaceBet,
              children: [
                Text(
                  '04/23',
                  style: CustomStyle.whiteh2,
                ),
                Text(
                  widget.selectedCardName ?? '',
                  style: CustomStyle.whiteh2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
