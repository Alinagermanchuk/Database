SELECT get_most_selling_game_by_genre('simulation');
/*   Output:
     "Space Engineers"
 */

CALL dev_games_stats();
/*   Output:
    ИНФОРМАЦИЯ:  Developer "Microsoft" has 1 games (total profit: 1.0 million dollars)
    ИНФОРМАЦИЯ:  Developer "Mythic Entertainment" has 1 games (total profit: 1.0 million dollars)
    ИНФОРМАЦИЯ:  Developer "Max Design" has 2 games (total profit: 4.0 million dollars)
    ИНФОРМАЦИЯ:  Developer "Studio Wildcard" has 1 games (total profit: 1.0 million dollars)
    ИНФОРМАЦИЯ:  Developer "Mediatonic" has 1 games (total profit: 10.0 million dollars)
    ИНФОРМАЦИЯ:  Developer "Epic Games" has 2 games (total profit: 2.0 million dollars)
    ИНФОРМАЦИЯ:  Developer "Coffee Stain Studios" has 1 games (total profit: 1.3 million dollars)
    ИНФОРМАЦИЯ:  Developer "Ensemble Studios" has 4 games (total profit: 8.0 million dollars)
    ИНФОРМАЦИЯ:  Developer "Electronic Arts" has 1 games (total profit: 2.0 million dollars)
         ...
    ИНФОРМАЦИЯ:  Developer "Facepunch Studios" has 2 games (total profit: 29.0 million dollars)
    CALL

    Query returned successfully in 72 msec.
 */

INSERT INTO SaleInfo VALUES (-1, -1.5);
/* Output:
    ИНФОРМАЦИЯ:  Sales can't be negative (your input: -1.5).
    INSERT 0 0

    Query returned successfully in 47 msec.
 */