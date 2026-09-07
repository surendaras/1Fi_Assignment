import 'package:flutter_test/flutter_test.dart';
import 'package:onefi_app/main.dart';
import 'package:onefi_app/screens/shop/shop_screen.dart';

void main() {
  testWidgets('Renders OneFiApp and navigates tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const OneFiApp());
    await tester.pumpAndSettle();

    // Verify ShopScreen is mounted
    expect(find.byType(ShopScreen), findsOneWidget);

    // Verify 3 options exist in the Shop tab
    expect(find.text('Top Brands'), findsOneWidget);
    expect(find.text('Nearby Stores'), findsOneWidget);
    expect(find.text('1Fi Marketplace'), findsOneWidget);

    // Switch to Top Brands tab
    await tester.tap(find.text('Top Brands'));
    await tester.pumpAndSettle();
    expect(find.text('Direct brand store partnerships with exclusive 1Fi credit & zero-interest vouchers are launching soon!'), findsOneWidget);

    // Switch to Nearby Stores tab
    await tester.tap(find.text('Nearby Stores'));
    await tester.pumpAndSettle();
    expect(find.text('Scan & Pay with 1Fi Credit at your local retail stores & electronic outlets. Feature coming to your city soon!'), findsOneWidget);

    // Switch back to 1Fi Marketplace
    await tester.tap(find.text('1Fi Marketplace'));
    await tester.pumpAndSettle();
    expect(find.text('Top Brands'), findsOneWidget);
  });
}
