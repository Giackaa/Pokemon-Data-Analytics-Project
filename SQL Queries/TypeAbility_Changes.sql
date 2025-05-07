WITH GEN1_2 AS
(SELECT 1 AS GEN_NUM,
			RB_Gen AS ORIGIN,
			RB_Pokemon AS POKEMON,
            RB_Type_1 AS Type_1,
            RB_Type_2 AS Type_2,
            RB_Ability_1 AS Ability_1,
            RB_Ability_2 AS Ability_2,
            RB_Ability_3 AS Ability_3 FROM gen_rb
	UNION
	SELECT 2 AS NUM,
			CASE WHEN a.RB_GEN IS NOT NULL THEN a.RB_GEN ELSE b.GS_GEN END,
            GS_Pokemon AS POKEMON,
            GS_Type_1,
            GS_Type_2,
            GS_Ability_1,
            GS_Ability_2,
            GS_Ability_3
            FROM gen_gs AS b
    LEFT JOIN gen_rb AS a ON a.RB_POKEMON = b.GS_POKEMON
),
GEN2_3 AS
(SELECT * FROM GEN1_2
	UNION
SELECT 3 AS NUM,
			CASE WHEN a.ORIGIN IS NOT NULL THEN a.ORIGIN ELSE b.RS_GEN END,
            RS_Pokemon,
            RS_Type_1,
            RS_Type_2,
            RS_Ability_1,
            RS_Ability_2,
            RS_Ability_3
            FROM gen_rs AS b
    LEFT JOIN GEN1_2 AS a ON a.POKEMON = b.RS_POKEMON
),
GEN3_4 AS
(SELECT * FROM GEN2_3
	UNION
SELECT 4 AS NUM,
			CASE WHEN a.ORIGIN IS NOT NULL THEN a.ORIGIN ELSE b.DP_GEN END,
            DP_Pokemon,
            DP_Type_1,
            DP_Type_2,
            DP_Ability_1,
            DP_Ability_2,
            DP_Ability_3
            FROM gen_dp AS b
    LEFT JOIN GEN2_3 AS a ON a.POKEMON = b.DP_POKEMON
),
GEN4_5 AS
(SELECT * FROM GEN3_4
	UNION
SELECT 5 AS NUM,
			CASE WHEN a.ORIGIN IS NOT NULL THEN a.ORIGIN ELSE b.BW_GEN END,
            BW_Pokemon,
            BW_Type_1,
            BW_Type_2,
            BW_Ability_1,
            BW_Ability_2,
            BW_Ability_3
            FROM gen_bw AS b
    LEFT JOIN GEN3_4 AS a ON a.POKEMON = b.BW_POKEMON
),
GEN5_6 AS
(SELECT * FROM GEN4_5
	UNION
SELECT 6 AS NUM,
			CASE WHEN a.ORIGIN IS NOT NULL THEN a.ORIGIN ELSE b.XY_GEN END,
            XY_Pokemon,
            XY_Type_1,
            XY_Type_2,
            XY_Ability_1,
            XY_Ability_2,
            XY_Ability_3
            FROM gen_xy AS b
    LEFT JOIN GEN4_5 AS a ON a.POKEMON = b.XY_POKEMON
),
GEN6_7 AS
(SELECT * FROM GEN5_6
	UNION
SELECT 7 AS NUM,
			CASE WHEN a.ORIGIN IS NOT NULL THEN a.ORIGIN ELSE b.SM_GEN END,
            SM_Pokemon,
            SM_Type_1,
            SM_Type_2,
            SM_Ability_1,
            SM_Ability_2,
            SM_Ability_3
            FROM gen_sm AS b
    LEFT JOIN GEN5_6 AS a ON a.POKEMON = b.SM_POKEMON
),
GEN7_8 AS
(SELECT * FROM GEN6_7
	UNION
SELECT 8 AS NUM,
			CASE WHEN a.ORIGIN IS NOT NULL THEN a.ORIGIN ELSE b.SS_GEN END,
            SS_Pokemon,
            SS_Type_1,
            SS_Type_2,
            SS_Ability_1,
            SS_Ability_2,
            SS_Ability_3
            FROM gen_ss AS b
    LEFT JOIN GEN6_7 AS a ON a.POKEMON = b.SS_POKEMON
),
GEN8_9 AS
(SELECT * FROM GEN7_8
	UNION
SELECT 9 AS NUM,
			CASE WHEN a.ORIGIN IS NOT NULL THEN a.ORIGIN ELSE b.SV_GEN END,
            SV_Pokemon,
            SV_Type_1,
            SV_Type_2,
            SV_Ability_1,
            SV_Ability_2,
            SV_Ability_3
            FROM gen_sv AS b
    LEFT JOIN GEN7_8 AS a ON a.POKEMON = b.SV_POKEMON
)
SELECT GEN_NUM,
	ORIGIN,
	SUM(CASE WHEN Type_1 != '' THEN 1 ELSE 0 END) AS COUNT_Type_1,
    SUM(CASE WHEN Type_2 != '' THEN 1 ELSE 0 END) AS COUNT_Type_2,
    SUM(CASE WHEN Ability_1 != '' THEN 1 ELSE 0 END) AS COUNT_Ability_1,
    SUM(CASE WHEN Ability_2 != '' THEN 1 ELSE 0 END) AS COUNT_Ability_2,
    SUM(CASE WHEN Ability_3 != '' THEN 1 ELSE 0 END) AS COUNT_Ability_3
FROM GEN8_9
GROUP BY ORIGIN, GEN_NUM
ORDER BY ORIGIN, GEN_NUM