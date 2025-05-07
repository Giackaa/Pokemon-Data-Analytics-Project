WITH G1_AvgSTATS AS (
    SELECT 1 AS NUM,
			RB_Gen AS GEN, 
           MAX(RB_Pokemon) AS Pokemon,
           AVG(RB_HP) AS AVG_HP,
           AVG(RB_ATK) AS AVG_ATK,
           AVG(RB_DEF) AS AVG_DEF,
           AVG(RB_SPA) AS AVG_SPA,
           AVG(RB_SPD) AS AVG_SPD,
           AVG(RB_SPE) AS AVG_SPE,
           'FALSE' AS Newly_Added
    FROM gen_rb
    GROUP BY RB_Gen
),
G2_AvgSTATS AS (
    SELECT 2 AS NUM,
			GS_Gen AS GEN, 
           MAX(GS_Pokemon),
           AVG(GS_HP),
           AVG(GS_ATK),
           AVG(GS_DEF),
           AVG(GS_SPA),
           AVG(GS_SPD),
           AVG(GS_SPE),
           'FALSE' AS Newly_Added
    FROM gen_gs AS a
    LEFT OUTER JOIN gen_rb AS b ON a.GS_Pokemon = b.RB_Pokemon
    WHERE RB_Pokemon IS NOT NULL
    GROUP BY GEN
),
G2_NewPokemonSTATS AS (
    SELECT 2 AS NUM,
			GS_Gen AS GEN, 
           MAX(GS_Pokemon),
           AVG(GS_HP),
           AVG(GS_ATK),
           AVG(GS_DEF),
           AVG(GS_SPA),
           AVG(GS_SPD),
           AVG(GS_SPE),
           'TRUE' AS Newly_Added
    FROM gen_gs AS a
    LEFT OUTER JOIN gen_rb AS b ON a.GS_Pokemon = b.RB_Pokemon
    WHERE RB_Pokemon IS NULL
    GROUP BY GEN
),
G3_AvgSTATS AS (
    SELECT 3 AS NUM,
			RS_Gen AS GEN, 
           MAX(RS_Pokemon),
           AVG(RS_HP),
           AVG(RS_ATK),
           AVG(RS_DEF),
           AVG(RS_SPA),
           AVG(RS_SPD),
           AVG(RS_SPE),
           'FALSE' AS Newly_Added
    FROM gen_rs AS a
    LEFT OUTER JOIN gen_gs AS b ON a.RS_Pokemon = b.GS_Pokemon
    WHERE GS_Pokemon IS NOT NULL
    GROUP BY RS_Gen
),
G3_NewPokemonSTATS AS (
    SELECT 3 AS NUM,
			RS_Gen AS GEN, 
           MAX(RS_Pokemon),
           AVG(RS_HP),
           AVG(RS_ATK),
           AVG(RS_DEF),
           AVG(RS_SPA),
           AVG(RS_SPD),
           AVG(RS_SPE),
           'TRUE' AS Newly_Added
    FROM gen_rs AS a
    LEFT OUTER JOIN gen_gs AS b ON a.RS_Pokemon = b.GS_Pokemon
    WHERE GS_Pokemon IS NULL
    GROUP BY RS_Gen
),
G4_AvgSTATS AS (
    SELECT 4 AS NUM,
			DP_Gen AS GEN, 
           MAX(DP_Pokemon),
           AVG(DP_HP),
           AVG(DP_ATK),
           AVG(DP_DEF),
           AVG(DP_SPA),
           AVG(DP_SPD),
           AVG(DP_SPE),
           'FALSE' AS Newly_Added
    FROM gen_dp AS a
    LEFT OUTER JOIN gen_rs AS b ON a.DP_Pokemon = b.RS_Pokemon
    WHERE RS_Pokemon IS NOT NULL
    GROUP BY DP_Gen 
),
G4_NewPokemonSTATS AS (
    SELECT 4 AS NUM,
			DP_Gen AS GEN, 
           MAX(DP_Pokemon),
           AVG(DP_HP),
           AVG(DP_ATK),
           AVG(DP_DEF),
           AVG(DP_SPA),
           AVG(DP_SPD),
           AVG(DP_SPE),
           'TRUE' AS Newly_Added
    FROM gen_dp AS a
    LEFT OUTER JOIN gen_rs AS b ON a.DP_Pokemon = b.RS_Pokemon
    WHERE RS_Pokemon IS NULL
    GROUP BY DP_Gen 
),
G5_AvgSTATS AS (
    SELECT 5 AS NUM,
			BW_Gen AS GEN, 
           MAX(BW_Pokemon),
           AVG(BW_HP),
           AVG(BW_ATK),
           AVG(BW_DEF),
           AVG(BW_SPA),
           AVG(BW_SPD),
           AVG(BW_SPE),
           'FALSE' AS Newly_Added
    FROM gen_bw AS a
    LEFT OUTER JOIN gen_dp AS b ON a.BW_Pokemon = b.DP_Pokemon
    WHERE DP_Pokemon IS NOT NULL
    GROUP BY BW_Gen 
),
G5_NewPokemonSTATS AS (
    SELECT 5 AS NUM,
			BW_Gen AS GEN, 
           MAX(BW_Pokemon),
           AVG(BW_HP),
           AVG(BW_ATK),
           AVG(BW_DEF),
           AVG(BW_SPA),
           AVG(BW_SPD),
           AVG(BW_SPE),
           'TRUE' AS Newly_Added
    FROM gen_bw AS a
    LEFT OUTER JOIN gen_dp AS b ON a.BW_Pokemon = b.DP_Pokemon
    WHERE DP_Pokemon IS NULL
    GROUP BY BW_Gen 
),
G6_AvgSTATS AS (
    SELECT 6 AS NUM,
			XY_Gen AS GEN, 
           MAX(XY_Pokemon),
           AVG(XY_HP),
           AVG(XY_ATK),
           AVG(XY_DEF),
           AVG(XY_SPA),
           AVG(XY_SPD),
           AVG(XY_SPE),
           'FALSE' AS Newly_Added
    FROM gen_xy AS a
    LEFT OUTER JOIN gen_bw AS b ON a.XY_Pokemon = b.bw_Pokemon
    WHERE bw_Pokemon IS NOT NULL
    GROUP BY XY_Gen 
),
G6_NewPokemonSTATS AS (
    SELECT 6 AS NUM,
			XY_Gen AS GEN, 
           MAX(XY_Pokemon),
           AVG(XY_HP),
           AVG(XY_ATK),
           AVG(XY_DEF),
           AVG(XY_SPA),
           AVG(XY_SPD),
           AVG(XY_SPE),
           'TRUE' AS Newly_Added
    FROM gen_xy AS a
    LEFT OUTER JOIN gen_bw AS b ON a.XY_Pokemon = b.bw_Pokemon
    WHERE bw_Pokemon IS NULL
    GROUP BY XY_Gen 
),
G7_AvgSTATS AS (
    SELECT 7 AS NUM,
			SM_Gen AS GEN, 
           MAX(SM_Pokemon),
           AVG(SM_HP),
           AVG(SM_ATK),
           AVG(SM_DEF),
           AVG(SM_SPA),
           AVG(SM_SPD),
           AVG(SM_SPE),
           'FALSE' AS Newly_Added
    FROM gen_sm AS a
    LEFT OUTER JOIN gen_xy AS b ON a.SM_Pokemon = b.XY_Pokemon
    WHERE XY_Pokemon IS NOT NULL
    GROUP BY SM_Gen 
),
G7_NewPokemonSTATS AS (
    SELECT 7 AS NUM,
			SM_Gen AS GEN, 
           MAX(SM_Pokemon),
           AVG(SM_HP),
           AVG(SM_ATK),
           AVG(SM_DEF),
           AVG(SM_SPA),
           AVG(SM_SPD),
           AVG(SM_SPE),
           'TRUE' AS Newly_Added
    FROM gen_sm AS a
    LEFT OUTER JOIN gen_xy AS b ON a.SM_Pokemon = b.XY_Pokemon
    WHERE XY_Pokemon IS NULL
    GROUP BY SM_Gen 
),
G8_AvgSTATS AS (
    SELECT 8 AS NUM,
			SS_Gen AS GEN, 
           MAX(SS_Pokemon),
           AVG(SS_HP),
           AVG(SS_ATK),
           AVG(SS_DEF),
           AVG(SS_SPA),
           AVG(SS_SPD),
           AVG(SS_SPE),
           'FALSE' AS Newly_Added
    FROM gen_ss AS a
    LEFT OUTER JOIN gen_sm AS b ON a.SS_Pokemon = b.SM_Pokemon
    WHERE SM_Pokemon IS NOT NULL
    GROUP BY SS_Gen 
),
G8_NewPokemonSTATS AS (
    SELECT 8 AS NUM,
			SS_Gen AS GEN, 
           MAX(SS_Pokemon),
           AVG(SS_HP),
           AVG(SS_ATK),
           AVG(SS_DEF),
           AVG(SS_SPA),
           AVG(SS_SPD),
           AVG(SS_SPE),
           'TRUE' AS Newly_Added
    FROM gen_ss AS a
    LEFT OUTER JOIN gen_sm AS b ON a.SS_Pokemon = b.SM_Pokemon
    WHERE SM_Pokemon IS NULL
    GROUP BY SS_Gen 
),
G9_AvgSTATS AS (
    SELECT 9 AS NUM,
			SV_Gen AS GEN, 
           MAX(SV_Pokemon),
           AVG(SV_HP),
           AVG(SV_ATK),
           AVG(SV_DEF),
           AVG(SV_SPA),
           AVG(SV_SPD),
           AVG(SV_SPE),
           'FALSE' AS Newly_Added
    FROM gen_sv AS a
    LEFT OUTER JOIN gen_ss AS b ON a.SV_Pokemon = b.SS_Pokemon
    WHERE SS_Pokemon IS NOT NULL
    GROUP BY SV_Gen 
),
G9_NewPokemonSTATS AS (
    SELECT 9 AS NUM,
			SV_Gen AS GEN, 
           MAX(SV_Pokemon),
           AVG(SV_HP),
           AVG(SV_ATK),
           AVG(SV_DEF),
           AVG(SV_SPA),
           AVG(SV_SPD),
           AVG(SV_SPE),
           'TRUE' AS Newly_Added
    FROM gen_sv AS a
    LEFT OUTER JOIN gen_ss AS b ON a.SV_Pokemon = b.SS_Pokemon
    WHERE SS_Pokemon IS NULL
    GROUP BY SV_Gen 
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
SELECT NUM,
	GEN, 
    Newly_Added,
	AVG_HP,
    AVG_HP - LAG(AVG_HP, 1, NULL) OVER(PARTITION BY GEN) AS VS_PrevHP,
    AVG_ATK,
    AVG_ATK - LAG(AVG_ATK, 1, NULL) OVER(PARTITION BY GEN) AS VS_PrevATK,
	AVG_DEF,
    AVG_DEF - LAG(AVG_DEF, 1, NULL) OVER(PARTITION BY GEN) AS VS_PrevDEF,
	AVG_SPA,
    AVG_SPA - LAG(AVG_SPA, 1, NULL) OVER(PARTITION BY GEN) AS VS_PrevSPA,
    AVG_SPD,
    AVG_SPD - LAG(AVG_SPD, 1, NULL) OVER(PARTITION BY GEN) AS VS_PrevSPD,
    AVG_SPE,
    AVG_SPE - LAG(AVG_SPE, 1, NULL) OVER(PARTITION BY GEN) AS VS_PrevSPE
FROM Final
ORDER BY NUM
