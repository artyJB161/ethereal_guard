import 'package:flutter_test/flutter_test.dart';
import 'package:ethereal_guard/main.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  // Disable font fetching during tests to avoid network errors and timeouts.
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Use the root widget NetGuardApp defined in lib/main.dart.
    await tester.pumpWidget(const NetGuardApp());
    // Wait for any initial animations or asynchronous provider initializations to settle.
    await tester.pumpAndSettle();

    // Verify that the login screen is shown with correct branding and titles.
    expect(find.text('NetGuard Mobile'), findsOneWidget);
    expect(find.text('Network Security Monitoring'), findsOneWidget);
    
    // Verify that the Login button is present on the screen.
    expect(find.text('Login'), findsOneWidget);
  });
}
