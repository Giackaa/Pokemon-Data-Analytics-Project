WITH G1_AvgSTATS AS (
    SELECT 1 AS NUM,
			RB_Gen AS GEN, 
           RB_Pokemon AS Pokemon,
           'FALSE' AS Newly_Added
    FROM gen_rb
),
G2_AvgSTATS AS (
    SELECT 2 AS NUM,
			GS_Gen AS GEN, 
           GS_Pokemon,
           'FALSE' AS Newly_Added
    FROM gen_gs AS a
    LEFT OUTER JOIN gen_rb AS b ON a.GS_Pokemon = b.RB_Pokemon
    WHERE RB_Pokemon IS NOT NULL

),
G2_NewPokemonSTATS AS (
    SELECT 2 AS NUM,
			GS_Gen AS GEN, 
           GS_Pokemon,
           'TRUE' AS Newly_Added
    FROM gen_gs AS a
    LEFT OUTER JOIN gen_rb AS b ON a.GS_Pokemon = b.RB_Pokemon
    WHERE RB_Pokemon IS NULL

),
G3_AvgSTATS AS (
    SELECT 3 AS NUM,
			RS_Gen AS GEN, 
           RS_Pokemon,
           'FALSE' AS Newly_Added
    FROM gen_rs AS a
    LEFT OUTER JOIN gen_gs AS b ON a.RS_Pokemon = b.GS_Pokemon
    WHERE GS_Pokemon IS NOT NULL

),
G3_NewPokemonSTATS AS (
    SELECT 3 AS NUM,
			RS_Gen AS GEN, 
           RS_Pokemon,
           'TRUE' AS Newly_Added
    FROM gen_rs AS a
    LEFT OUTER JOIN gen_gs AS b ON a.RS_Pokemon = b.GS_Pokemon
    WHERE GS_Pokemon IS NULL

),
G4_AvgSTATS AS (
    SELECT 4 AS NUM,
			DP_Gen AS GEN, 
           DP_Pokemon,
           'FALSE' AS Newly_Added
    FROM gen_dp AS a
    LEFT OUTER JOIN gen_rs AS b ON a.DP_Pokemon = b.RS_Pokemon
    WHERE RS_Pokemon IS NOT NULL

),
G4_NewPokemonSTATS AS (
    SELECT 4 AS NUM,
			DP_Gen AS GEN, 
           DP_Pokemon,
           'TRUE' AS Newly_Added
    FROM gen_dp AS a
    LEFT OUTER JOIN gen_rs AS b ON a.DP_Pokemon = b.RS_Pokemon
    WHERE RS_Pokemon IS NULL

),
G5_AvgSTATS AS (
    SELECT 5 AS NUM,
			BW_Gen AS GEN, 
           BW_Pokemon,
           'FALSE' AS Newly_Added
    FROM gen_bw AS a
    LEFT OUTER JOIN gen_dp AS b ON a.BW_Pokemon = b.DP_Pokemon
    WHERE DP_Pokemon IS NOT NULL

),
G5_NewPokemonSTATS AS (
    SELECT 5 AS NUM,
			BW_Gen AS GEN, 
           BW_Pokemon,
           'TRUE' AS Newly_Added
    FROM gen_bw AS a
    LEFT OUTER JOIN gen_dp AS b ON a.BW_Pokemon = b.DP_Pokemon
    WHERE DP_Pokemon IS NULL

),
G6_AvgSTATS AS (
    SELECT 6 AS NUM,
			XY_Gen AS GEN, 
           XY_Pokemon,
           'FALSE' AS Newly_Added
    FROM gen_xy AS a
    LEFT OUTER JOIN gen_bw AS b ON a.XY_Pokemon = b.bw_Pokemon
    WHERE bw_Pokemon IS NOT NULL

),
G6_NewPokemonSTATS AS (
    SELECT 6 AS NUM,
			XY_Gen AS GEN, 
           XY_Pokemon,
           'TRUE' AS Newly_Added
    FROM gen_xy AS a
    LEFT OUTER JOIN gen_bw AS b ON a.XY_Pokemon = b.bw_Pokemon
    WHERE bw_Pokemon IS NULL

),
G7_AvgSTATS AS (
    SELECT 7 AS NUM,
			SM_Gen AS GEN, 
           SM_Pokemon,
           'FALSE' AS Newly_Added
    FROM gen_sm AS a
    LEFT OUTER JOIN gen_xy AS b ON a.SM_Pokemon = b.XY_Pokemon
    WHERE XY_Pokemon IS NOT NULL
),
G7_NewPokemonSTATS AS (
    SELECT 7 AS NUM,
			SM_Gen AS GEN, 
           SM_Pokemon,
           'TRUE' AS Newly_Added
    FROM gen_sm AS a
    LEFT OUTER JOIN gen_xy AS b ON a.SM_Pokemon = b.XY_Pokemon
    WHERE XY_Pokemon IS NULL
),
G8_AvgSTATS AS (
    SELECT 8 AS NUM,
			SS_Gen AS GEN, 
           SS_Pokemon,
           'FALSE' AS Newly_Added
    FROM gen_ss AS a
    LEFT OUTER JOIN gen_sm AS b ON a.SS_Pokemon = b.SM_Pokemon
    WHERE SM_Pokemon IS NOT NULL
),
G8_NewPokemonSTATS AS (
    SELECT 8 AS NUM,
			SS_Gen AS GEN, 
           SS_Pokemon,
           'TRUE' AS Newly_Added
    FROM gen_ss AS a
    LEFT OUTER JOIN gen_sm AS b ON a.SS_Pokemon = b.SM_Pokemon
    WHERE SM_Pokemon IS NULL
),
G9_AvgSTATS AS (
    SELECT 9 AS NUM,
			SV_Gen AS GEN, 
           SV_Pokemon,
           'FALSE' AS Newly_Added
    FROM gen_sv AS a
    LEFT OUTER JOIN gen_ss AS b ON a.SV_Pokemon = b.SS_Pokemon
    WHERE SS_Pokemon IS NOT NULL

),
G9_NewPokemonSTATS AS (
    SELECT 9 AS NUM,
			SV_Gen AS GEN, 
           SV_Pokemon,
           'TRUE' AS Newly_Added
    FROM gen_sv AS a
    LEFT OUTER JOIN gen_ss AS b ON a.SV_Pokemon = b.SS_Pokemon
    WHERE SS_Pokemon IS NULL
),
Final AS (
	SELECT * FROM G1_AvgSTATS
		UNION ALL
	SELECT * FROM G2_AvgSTATS
		UNION ALL
	SELECT * FROM G2_NEWPOKEMONSTATS
		UNION ALL
	SELECT * FROM G3_AVGSTATS
		UNION ALL
	SELECT * FROM G3_NEWPOKEMONSTATS
		UNION ALL
	SELECT * FROM G4_AVGSTATS
		UNION ALL
	SELECT * FROM G4_NEWPOKEMONSTATS
		UNION ALL
	SELECT * FROM G5_AVGSTATS
		UNION ALL
	SELECT * FROM G5_NEWPOKEMONSTATS
		UNION ALL
	SELECT * FROM G6_AVGSTATS
		UNION ALL
	SELECT * FROM G6_NEWPOKEMONSTATS
		UNION ALL
	SELECT * FROM G7_AVGSTATS
		UNION ALL
	SELECT * FROM G7_NEWPOKEMONSTATS
		UNION ALL
	SELECT * FROM G8_AVGSTATS
		UNION ALL
	SELECT * FROM G8_NEWPOKEMONSTATS
		UNION ALL
	SELECT * FROM G9_AVGSTATS
		UNION ALL
	SELECT * FROM G9_NEWPOKEMONSTATS
)
SELECT GEN, POKEMON, NEWLY_ADDED
FROM Final
ORDER BY NUM