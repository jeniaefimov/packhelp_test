I believe I didn't get the idea about how engine API should looks like, so I created 2 versions of `CalculateTotals` controller:

One receives all fields of the main user as params, converts PLN to EUR and stores just `Calculation::User` to the DB (Main app user updated in their own controller via `Calculation::EuroConverter.new(amount).call`). This one is covered with tests.

The second one (`CalculateTotalsSecondVersionController`) using another approach: it receives only id of the main app user as a param, then using interface (`CalculationApi::UserHelper`) fetches user and updates both `User` and `Calculation::User` in the engine's controller. Not covered with tests, created to show the idea.

If I still didn't get the idea correctly, I'm ready to fix it ASAP both during the live call or at home.

List of other things I think could be discussed/improved:
- Generate API documentation (I prepared existing manually)
- any kind of return object instead of just hash in `EuroConverter` class
- move `calculation` to the `engines` folder
