WITH TEMP AS
	(SELECT *,
		(HP+ATK+DEF+SPA+SPD+SPE) AS OVERALL,
		RANK() OVER(PARTITION BY POKEMON ORDER BY NUM ASC) AS MIN_GEN,
		RANK() OVER(PARTITION BY POKEMON ORDER BY NUM DESC) AS MAX_GEN
		FROM	
			(SELECT RB_GEN AS GEN, 1 AS NUM, RB_POKEMON AS POKEMON, RB_HP AS HP, RB_ATK AS ATK, RB_DEF AS DEF, RB_SPA AS SPA, RB_SPD AS SPD, RB_SPE AS SPE FROM gen_rb
				UNION
			SELECT GS_GEN AS GEN, 2 AS NUM, GS_POKEMON AS POKEMON, GS_HP AS HP, GS_ATK AS ATK, GS_DEF AS DEF, GS_SPA AS SPA, GS_SPD AS SPD, GS_SPE AS SPE FROM gen_gs
				UNION
			SELECT RS_GEN AS GEN, 3 AS NUM, RS_POKEMON AS POKEMON, RS_HP AS HP, RS_ATK AS ATK, RS_DEF AS DEF, RS_SPA AS SPA, RS_SPD AS SPD, RS_SPE AS SPE FROM gen_rs
				UNION
			SELECT DP_GEN AS GEN, 4 AS NUM, DP_POKEMON AS POKEMON, DP_HP AS HP, DP_ATK AS ATK, DP_DEF AS DEF, DP_SPA AS SPA, DP_SPD AS SPD, DP_SPE AS SPE FROM gen_dp
				UNION
			SELECT BW_GEN AS GEN, 5 AS NUM, BW_POKEMON AS POKEMON, BW_HP AS HP, BW_ATK AS ATK, BW_DEF AS DEF, BW_SPA AS SPA, BW_SPD AS SPD, BW_SPE AS SPE FROM gen_bw
				UNION
			SELECT XY_GEN AS GEN, 6 AS NUM, XY_POKEMON AS POKEMON, XY_HP AS HP, XY_ATK AS ATK, XY_DEF AS DEF, XY_SPA AS SPA, XY_SPD AS SPD, XY_SPE AS SPE FROM gen_xy
				UNION
			SELECT SM_GEN AS GEN, 7 AS NUM, SM_POKEMON AS POKEMON, SM_HP AS HP, SM_ATK AS ATK, SM_DEF AS DEF, SM_SPA AS SPA, SM_SPD AS SPD, SM_SPE AS SPE FROM gen_sm
				UNION
			SELECT SS_GEN AS GEN, 8 AS NUM, SS_POKEMON AS POKEMON, SS_HP AS HP, SS_ATK AS ATK, SS_DEF AS DEF, SS_SPA AS SPA, SS_SPD AS SPD, SS_SPE AS SPE FROM gen_ss
				UNION
			SELECT SV_GEN AS GEN, 9 AS NUM, SV_POKEMON AS POKEMON, SV_HP AS HP, SV_ATK AS ATK, SV_DEF AS DEF, SV_SPA AS SPA, SV_SPD AS SPD, SV_SPE AS SPE FROM gen_sv
		) AS STATS
	ORDER BY POKEMON, NUM
),
TEMP2 AS (
	SELECT *, LEAD(OVERALL,1,OVERALL) OVER(PARTITION BY POKEMON ORDER BY NUM) - OVERALL AS CHANGES_BY_GEN9
    FROM TEMP
    WHERE MIN_GEN = 1 OR MAX_GEN = 1
)
SELECT GEN AS STARTING_GEN,
	NUM,
	POKEMON,
    HP,
    ATK,
    DEF,
    SPA,
    SPD,
    SPE,
    OVERALL,
    CHANGES_BY_GEN9
FROM TEMP2 AS a
WHERE MIN_GEN = 1
ORDER BY NUM


