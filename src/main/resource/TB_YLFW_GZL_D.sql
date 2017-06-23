SELECT
  SYS_GUID(),
  DS.F_YEAR,
  DS.F_QUARTER,
  DS.F_MONTH,
  DS.F_WEEK,
  DS.F_DAY,
  DS.F_SJQJ,
  DS.F_SJQH_DM,
  DS.F_XZQX_DM,
  DS.F_YLJG_ID,
  DS.F_YLJG_TYPE,
  DS.F_YLJG_JGLSGXDM,
  NVL(DS.F_XB, '0'),
  NVL(DS.F_YNDM, '-1'),
  DS.F_KS_DM,
  DS.F_YS_UUID,
  DS.F_YS_GH,
  DS.F_YS_MC,
  SUM(DS.MZRC)      AS MZRC,
  SUM(DS.MZRC_ZY)   AS MZRC_ZY,
  SUM(DS.MZRC_XY)   AS MZRC_XY,
  SUM(DS.PTMZRC)    AS PTMZRC,
  SUM(DS.PTMZRC_ZY) AS PTMZRC_ZY,
  SUM(DS.PTMZRC_XY) AS PTMZRC_XY,
  SUM(DS.MJZRC)     AS MJZRC,
  SUM(DS.YYZLRC)    AS YYZLRC,
  SUM(DS.YYZLRC_ZY) AS YYZLRC_ZY,
  SUM(DS.YYZLRC_XY) AS YYZLRC_XY,
  SUM(DS.MZJZRC)    AS MZJZRC,
  SUM(DS.MZJZRC_ZY) AS MZJZRC_ZY,
  SUM(DS.MZJZRC_XY) AS MZJZRC_XY,
  SUM(DS.RYRC)      AS RYRC,
  SUM(DS.RYRC_ZY)   AS RYRC_ZY,
  SUM(DS.RYRC_XY)   AS RYRC_XY,
  SUM(DS.CYRC)      AS CYRC,
  SUM(DS.CYRC_ZY)   AS CYRC_ZY,
  SUM(DS.CYRC_XY)   AS CYRC_XY,
  SUM(DS.SSZRC)     AS SSZRC,
  SUM(DS.MZSSZRC)   AS MZSSZRC,
  SUM(DS.ZYSSZRC)   AS ZYSSZRC,
  SYSDATE
FROM (
       SELECT
         C.F_YEAR                 AS F_YEAR,
         C.F_SEASON               AS F_QUARTER,
         C.F_MONTH                AS F_MONTH,
         C.F_WEEK                 AS F_WEEK,
         C.F_DAY                  AS F_DAY,
         NVL(TD.F_SJQJ, '02')     AS F_SJQJ,
         D.XNXZQHDM               AS F_XZQX_DM,
         E.SJJGID                 AS F_SJQH_DM,
         A.YLJGDMID               AS F_YLJG_ID,
         SUBSTR(D.WSJGLBDM, 1, 4) AS F_YLJG_TYPE,
         D.JGLSGXDM               AS F_YLJG_JGLSGXDM,
         SUBSTR(A.YSKSPTDM, 1, 2) AS F_KS_DM,
         A.YSID                   AS F_YS_UUID,
         A.GHYSGH                 AS F_YS_GH,
         A.GHYSXM                 AS F_YS_MC,
         B.XB                     AS F_XB,
         DECODE(TO_CHAR(B.CSRQ, 'YYYYMMDD'),
                '19000101',
                '-1',
                TY.F_NNQJ_DM)     AS F_YNDM,
         SUM(CASE
             WHEN A.GTHBZ = '1'
               THEN
                 1
             WHEN A.GTHBZ = '2'
               THEN
                 -1
             ELSE
               0
             END)                 AS MZRC,
         SUM(CASE
             WHEN A.GTHBZ = '1' AND A.LCYXLXBM <> '01'
               THEN
                 1
             WHEN A.GTHBZ = '2' AND A.LCYXLXBM <> '01'
               THEN
                 -1
             ELSE
               0
             END)                 AS MZRC_ZY,
         SUM(CASE
             WHEN A.GTHBZ = '1' AND A.LCYXLXBM = '01'
               THEN
                 1
             WHEN A.GTHBZ = '2' AND A.LCYXLXBM = '01'
               THEN
                 -1
             ELSE
               0
             END)                 AS MZRC_XY,
         SUM(CASE
             WHEN A.GTHBZ = '1' AND /*A.GHLB <> '200'*/ A.SFJZ = '0'
               THEN
                 1
             WHEN A.GTHBZ = '2' AND /*A.GHLB <> '200'*/ A.SFJZ = '0'
               THEN
                 -1
             ELSE
               0
             END)                 AS PTMZRC,
         SUM(CASE
             WHEN A.GTHBZ = '1' AND A.SFJZ = '0' AND
                  A.LCYXLXBM <> '01'
               THEN
                 1
             WHEN A.GTHBZ = '2' AND A.SFJZ = '0' AND
                  A.LCYXLXBM <> '01'
               THEN
                 -1
             ELSE
               0
             END)                 AS PTMZRC_ZY,
         SUM(CASE
             WHEN A.GTHBZ = '1' AND A.SFJZ = '0' AND
                  A.LCYXLXBM = '01'
               THEN
                 1
             WHEN A.GTHBZ = '2' AND A.SFJZ = '0' AND
                  A.LCYXLXBM = '01'
               THEN
                 -1
             ELSE
               0
             END)                 AS PTMZRC_XY,
         SUM(CASE
             WHEN A.GTHBZ = '1' AND A.SFJZ <> '0'
               THEN
                 1
             WHEN A.GTHBZ = '2' AND A.SFJZ <> '0'
               THEN
                 -1
             ELSE
               0
             END)                 AS MJZRC,
         SUM(CASE
             WHEN A.GTHBZ = '1' AND
                  A.GHTJBM IN ('02',
                               '0201',
                               '0299',
                               '03',
                               '0301',
                               '0302',
                               '0399',
                               '04',
                               '0401',
                               '0499')
               THEN
                 1
             WHEN A.GTHBZ = '2' AND
                  A.GHTJBM IN ('02',
                               '0201',
                               '0299',
                               '03',
                               '0301',
                               '0302',
                               '0399',
                               '04',
                               '0401',
                               '0499')
               THEN
                 -1
             ELSE
               0
             END)                 AS YYZLRC,
         SUM(CASE
             WHEN A.GTHBZ = '1' AND
                  A.GHTJBM IN ('02',
                               '0201',
                               '0299',
                               '03',
                               '0301',
                               '0302',
                               '0399',
                               '04',
                               '0401',
                               '0499') AND A.LCYXLXBM <> '01'
               THEN
                 1
             WHEN A.GTHBZ = '2' AND
                  A.GHTJBM IN ('02',
                               '0201',
                               '0299',
                               '03',
                               '0301',
                               '0302',
                               '0399',
                               '04',
                               '0401',
                               '0499') AND A.LCYXLXBM <> '01'
               THEN
                 -1
             ELSE
               0
             END)                 AS YYZLRC_ZY,
         SUM(CASE
             WHEN A.GTHBZ = '1' AND
                  A.GHTJBM IN ('02',
                               '0201',
                               '0299',
                               '03',
                               '0301',
                               '0302',
                               '0399',
                               '04',
                               '0401',
                               '0499') AND A.LCYXLXBM = '01'
               THEN
                 1
             WHEN A.GTHBZ = '2' AND
                  A.GHTJBM IN ('02',
                               '0201',
                               '0299',
                               '03',
                               '0301',
                               '0302',
                               '0399',
                               '04',
                               '0401',
                               '0499') AND A.LCYXLXBM = '01'
               THEN
                 -1
             ELSE
               0
             END)                 AS YYZLRC_XY,
         0                        AS MZJZRC,
         0                        AS MZJZRC_ZY,
         0                        AS MZJZRC_XY,
         0                        AS RYRC,
         0                        AS RYRC_ZY,
         0                        AS RYRC_XY,
         0                        AS CYRC,
         0                        AS CYRC_ZY,
         0                        AS CYRC_XY,
         0                        AS SSZRC,
         0                        AS MZSSZRC,
         0                        AS ZYSSZRC
       FROM TB_MZ_GHMXB A
         LEFT JOIN TB_HIS_PATINF B
           ON A.BRWYID = B.BRWYID AND a.kh = b.kh AND a.klx = b.klx
         LEFT JOIN TB_DIC_SJQJ TD
           ON F_START_TIME <= TO_CHAR(A.GTHSJ, 'HH24:MI:SS')
              AND F_END_TIME > TO_CHAR(A.GTHSJ, 'HH24:MI:SS')
         LEFT JOIN TB_DIC_NNQJ TY
           ON F_START_NN <=
              TRUNC(MONTHS_BETWEEN(A.GTHSJ, NVL(B.CSRQ, A.GTHSJ)) / 12)
              AND F_END_NN >=
                  TRUNC(MONTHS_BETWEEN(A.GTHSJ, NVL(B.CSRQ, A.GTHSJ)) / 12)
         INNER JOIN TB_DIC_DIM_DATE C
           ON TRUNC(A.GTHSJ) = TRUNC(C.F_TODAY)
         INNER JOIN TB_DIC_WD_YLJGZDB D
           ON A.YLJGDMID = D.YLJGID
         INNER JOIN TB_DIC_WD_WSXZJGZDB E
           ON D.XNXZQHDM = E.XZQHDM
       WHERE A.GTHSJ >= D_START_DATE
             AND A.GTHSJ <= D_END_DATE
       GROUP BY C.F_YEAR,
         C.F_SEASON,
         C.F_MONTH,
         C.F_WEEK,
         C.F_DAY,
         NVL(TD.F_SJQJ, '02'),
         D.XNXZQHDM,
         E.SJJGID,
         A.YLJGDMID,
         SUBSTR(D.WSJGLBDM, 1, 4),
         D.JGLSGXDM,
         SUBSTR(A.YSKSPTDM, 1, 2),
         A.YSID,
         A.GHYSGH,
         A.GHYSXM,
         B.XB,
         DECODE(TO_CHAR(B.CSRQ, 'YYYYMMDD'),
                '19000101',
                '-1',
                TY.F_NNQJ_DM)
       UNION ALL
       SELECT
         C.F_YEAR                 AS F_YEAR,
         C.F_SEASON               AS F_QUARTER,
         C.F_MONTH                AS F_MONTH,
         C.F_WEEK                 AS F_WEEK,
         C.F_DAY                  AS F_DAY,
         NVL(TD.F_SJQJ, '02')     AS F_SJQJ,
         D.XNXZQHDM               AS F_XZQX_DM,
         E.SJJGID                 AS F_SJQH_DM,
         A.YLJGDMID               AS F_YLJG_ID,
         SUBSTR(D.WSJGLBDM, 1, 4) AS F_YLJG_TYPE,
         D.JGLSGXDM               AS F_YLJG_JGLSGXDM,
         SUBSTR(A.JZKSPTDM, 1, 2) AS F_KS_DM,
         A.ZZYSID                 AS F_YS_UUID,
         A.ZZYSGH                 AS F_YS_GH,
         A.ZZYSXM                 AS F_YS_MC,
         NVL(B.XB, '-')           AS F_XB,
         DECODE(TO_CHAR(B.CSRQ, 'YYYYMMDD'),
                '19000101',
                '-1',
                TY.F_NNQJ_DM)     AS F_YNDM,
         0                        AS MZRC,
         0                        AS MZRC_ZY,
         0                        AS MZRC_XY,
         0                        AS PTMZRC,
         0                        AS PTMZRC_ZY,
         0                        AS PTMZRC_XY,
         0                        AS MJZRC,
         0                        AS YYZLRC,
         0                        AS YYZLRC_ZY,
         0                        AS YYZLRC_XY,
         SUM(1)                   AS MZJZRC,
         SUM(CASE
             WHEN LCYXLXBM <> '01'
               THEN
                 1
             ELSE
               0
             END)                 AS MZJZRC_ZY,
         SUM(CASE
             WHEN LCYXLXBM = '01'
               THEN
                 1
             ELSE
               0
             END)                 AS MZJZRC_XY,
         0                        AS RYRC,
         0                        AS RYRC_ZY,
         0                        AS RYRC_XY,
         0                        AS CYRC,
         0                        AS CYRC_ZY,
         0                        AS CYRC_XY,
         0                        AS SSZRC,
         0                        AS MZSSZRC,
         0                        AS ZYSSZRC
       FROM TB_MZ_JZMXB A
         LEFT JOIN TB_HIS_PATINF B
           ON A.BRWYID = B.BRWYID AND a.kh = b.kh AND a.klx = b.klx
         LEFT JOIN TB_DIC_SJQJ TD
           ON F_START_TIME <= TO_CHAR(TO_DATE(A.JZKSRQ, 'YYYYMMDD'), 'HH24:MI:SS')
              AND F_END_TIME > TO_CHAR(TO_DATE(A.JZKSRQ, 'YYYYMMDD'), 'HH24:MI:SS')
         LEFT JOIN TB_DIC_NNQJ TY
           ON F_START_NN <= TRUNC(MONTHS_BETWEEN(TO_DATE(A.JZKSRQ, 'YYYYMMDD'), B.CSRQ) / 12)
              AND F_END_NN >= TRUNC(MONTHS_BETWEEN(TO_DATE(A.JZKSRQ, 'YYYYMMDD'), B.CSRQ) / 12)
         INNER JOIN TB_DIC_DIM_DATE C
           ON JZKSRQ = C.F_DAY
         INNER JOIN TB_DIC_WD_YLJGZDB D
           ON A.YLJGDMID = D.YLJGID
         INNER JOIN TB_DIC_WD_WSXZJGZDB E
           ON D.XNXZQHDM = E.XZQHDM
       WHERE A.RKBZ <> '3'
             AND IS_DATE(A.JZKSRQ) = 1
             AND A.JZKSRQ >= TO_CHAR(D_START_DATE, 'YYYYMMDD')
             AND A.JZKSRQ <= TO_CHAR(D_END_DATE, 'YYYYMMDD')
       GROUP BY C.F_YEAR,
         C.F_SEASON,
         C.F_MONTH,
         C.F_WEEK,
         C.F_DAY,
         NVL(TD.F_SJQJ, '02'),
         D.XNXZQHDM,
         E.SJJGID,
         A.YLJGDMID,
         SUBSTR(D.WSJGLBDM, 1, 4),
         D.JGLSGXDM,
         SUBSTR(A.JZKSPTDM, 1, 2),
         A.ZZYSID,
         A.ZZYSGH,
         A.ZZYSXM,
         NVL(B.XB, '-'),
         DECODE(TO_CHAR(B.CSRQ, 'YYYYMMDD'),
                '19000101',
                '-1',
                TY.F_NNQJ_DM)
       UNION ALL
       SELECT
         C.F_YEAR                 AS F_YEAR,
         C.F_SEASON               AS F_QUARTER,
         C.F_MONTH                AS F_MONTH,
         C.F_WEEK                 AS F_WEEK,
         C.F_DAY                  AS F_DAY,
         NVL(TD.F_SJQJ, '02')     AS F_SJQJ,
         D.XNXZQHDM               AS F_XZQX_DM,
         E.SJJGID                 AS F_SJQH_DM,
         A.YLJGDMID               AS F_YLJG_ID,
         SUBSTR(D.WSJGLBDM, 1, 4) AS F_YLJG_TYPE,
         D.JGLSGXDM               AS F_YLJG_JGLSGXDM,
         SUBSTR(A.RYKSPTDM, 1, 2) AS F_KS_DM,
         A.MZYSID                 AS F_YS_UUID,
         A.MZYSGH                 AS F_YS_GH,
         A.MZYSXM                 AS F_YS_MC,
         NVL(B.XB, '-')           AS F_XB,
         DECODE(TO_CHAR(B.CSRQ, 'YYYYMMDD'),
                '19000101',
                '-1',
                TY.F_NNQJ_DM)     AS F_YNDM,
         0                        AS MZRC,
         0                        AS MZRC_ZY,
         0                        AS MZRC_XY,
         0                        AS PTMZRC,
         0                        AS PTMZRC_ZY,
         0                        AS PTMZRC_XY,
         0                        AS MJZRC,
         0                        AS YYZLRC,
         0                        AS YYZLRC_ZY,
         0                        AS YYZLRC_XY,
         0                        AS MZJZRC,
         0                        AS MZJZRC_ZY,
         0                        AS MZJZRC_XY,
         SUM(CASE
             WHEN A.SJJLZT = '1'
               THEN
                 1
             WHEN A.SJJLZT = '2'
               THEN
                 -1
             ELSE
               0
             END)                 AS RYRC,
         SUM(CASE
             WHEN A.SJJLZT = '1' AND NVL(TA.ZLLB, '3') <> '3'
               THEN
                 1
             WHEN A.SJJLZT = '2' AND NVL(TA.ZLLB, '3') <> '3'
               THEN
                 -1
             ELSE
               0
             END)                 AS RYRC_ZY,
         SUM(CASE
             WHEN A.SJJLZT = '1' AND NVL(TA.ZLLB, '3') = '3'
               THEN
                 1
             WHEN A.SJJLZT = '2' AND NVL(TA.ZLLB, '3') = '3'
               THEN
                 -1
             ELSE
               0
             END)                 AS RYRC_XY,
         0                        AS CYRC,
         0                        AS CYRC_ZY,
         0                        AS CYRC_XY,
         0                        AS SSZRC,
         0                        AS MZSSZRC,
         0                        AS ZYSSZRC
       FROM TB_ZY_RYDJMXB A
         LEFT JOIN TB_BA_JBXX TA
           ON A.YLJGDM = TA.YLJGDM
              AND A.ZYJZLSH = TA.JZLSH
         LEFT JOIN TB_HIS_PATINF B
           ON A.BRWYID = B.BRWYID AND a.kh = b.kh AND a.klx = b.klx
         LEFT JOIN TB_DIC_SJQJ TD
           ON F_START_TIME <= TO_CHAR(A.RYSJ, 'HH24:MI:SS')
              AND F_END_TIME > TO_CHAR(A.RYSJ, 'HH24:MI:SS')
         LEFT JOIN TB_DIC_NNQJ TY
           ON F_START_NN <= TRUNC(MONTHS_BETWEEN(A.RYSJ, B.CSRQ) / 12)
              AND F_END_NN >= TRUNC(MONTHS_BETWEEN(A.RYSJ, B.CSRQ) / 12)
         INNER JOIN TB_DIC_DIM_DATE C
           ON TRUNC(A.RYSJ) = TRUNC(C.F_TODAY)
         INNER JOIN TB_DIC_WD_YLJGZDB D
           ON A.YLJGDMID = D.YLJGID
         INNER JOIN TB_DIC_WD_WSXZJGZDB E
           ON D.XNXZQHDM = E.XZQHDM
       WHERE A.RKBZ <> '3'
             AND A.RYSJ >= D_START_DATE
             AND A.RYSJ <= D_END_DATE
       GROUP BY C.F_YEAR,
         C.F_SEASON,
         C.F_MONTH,
         C.F_WEEK,
         C.F_DAY,
         NVL(TD.F_SJQJ, '02'),
         D.XNXZQHDM,
         E.SJJGID,
         A.YLJGDMID,
         SUBSTR(D.WSJGLBDM, 1, 4),
         D.JGLSGXDM,
         SUBSTR(A.RYKSPTDM, 1, 2),
         A.MZYSID,
         A.MZYSGH,
         A.MZYSXM,
         NVL(B.XB, '-'),
         DECODE(TO_CHAR(B.CSRQ, 'YYYYMMDD'),
                '19000101',
                '-1',
                TY.F_NNQJ_DM)
       UNION ALL
       SELECT
         C.F_YEAR                 AS F_YEAR,
         C.F_SEASON               AS F_QUARTER,
         C.F_MONTH                AS F_MONTH,
         C.F_WEEK                 AS F_WEEK,
         C.F_DAY                  AS F_DAY,
         NVL(TD.F_SJQJ, '02')     AS F_SJQJ,
         D.XNXZQHDM               AS F_XZQX_DM,
         E.SJJGID                 AS F_SJQH_DM,
         A.YLJGDMID               AS F_YLJG_ID,
         SUBSTR(D.WSJGLBDM, 1, 4) AS F_YLJG_TYPE,
         D.JGLSGXDM               AS F_YLJG_JGLSGXDM,
         SUBSTR(A.CYKSPTDM, 1, 2) AS F_KS_DM,
         A.ZYYSID                 AS F_YS_UUID,
         A.ZYYSGH                 AS F_YS_GH,
         A.ZYYSXM                 AS F_YS_MC,
         NVL(B.XB, '-')           AS F_XB,
         DECODE(TO_CHAR(B.CSRQ, 'YYYYMMDD'),
                '19000101',
                '-1',
                TY.F_NNQJ_DM)     AS F_YNDM,
         0                        AS MZRC,
         0                        AS MZRC_ZY,
         0                        AS MZRC_XY,
         0                        AS PTMZRC,
         0                        AS PTMZRC_ZY,
         0                        AS PTMZRC_XY,
         0                        AS MJZRC,
         0                        AS YYZLRC,
         0                        AS YYZLRC_ZY,
         0                        AS YYZLRC_XY,
         0                        AS MZJZRC,
         0                        AS MZJZRC_ZY,
         0                        AS MZJZRC_XY,
         0                        AS RYRC,
         0                        AS RYRC_ZY,
         0                        AS RYRC_XY,
         SUM(CASE
             WHEN A.SJJLZT = '1'
               THEN
                 1
             WHEN A.SJJLZT = '2'
               THEN
                 -1
             ELSE
               0
             END)                 AS CYRC,
         SUM(CASE
             WHEN A.SJJLZT = '1' AND NVL(TA.ZLLB, '3') <> '3'
               THEN
                 1
             WHEN A.SJJLZT = '2' AND NVL(TA.ZLLB, '3') <> '3'
               THEN
                 -1
             ELSE
               0
             END)                 AS CYRC_ZY,
         SUM(CASE
             WHEN A.SJJLZT = '1' AND NVL(TA.ZLLB, '3') = '3'
               THEN
                 1
             WHEN A.SJJLZT = '2' AND NVL(TA.ZLLB, '3') = '3'
               THEN
                 -1
             ELSE
               0
             END)                 AS CYRC_XY,
         0                        AS SSZRC,
         0                        AS MZSSZRC,
         0                        AS ZYSSZRC
       FROM TB_ZY_CYDJMXB A
         LEFT JOIN TB_BA_JBXX TA
           ON A.YLJGDM = TA.YLJGDM
              AND A.ZYJZLSH = TA.JZLSH
         LEFT JOIN TB_HIS_PATINF B
           ON A.BRWYID = B.BRWYID AND a.kh = b.kh AND a.klx = b.klx
         LEFT JOIN TB_DIC_SJQJ TD
           ON F_START_TIME <= TO_CHAR(A.CYSJ, 'HH24:MI:SS')
              AND F_END_TIME > TO_CHAR(A.CYSJ, 'HH24:MI:SS')
         LEFT JOIN TB_DIC_NNQJ TY
           ON F_START_NN <= TRUNC(MONTHS_BETWEEN(A.CYSJ, B.CSRQ) / 12)
              AND F_END_NN >= TRUNC(MONTHS_BETWEEN(A.CYSJ, B.CSRQ) / 12)
         INNER JOIN TB_DIC_DIM_DATE C
           ON TRUNC(A.CYSJ) = TRUNC(C.F_TODAY)
         INNER JOIN TB_DIC_WD_YLJGZDB D
           ON A.YLJGDMID = D.YLJGID
         INNER JOIN TB_DIC_WD_WSXZJGZDB E
           ON D.XNXZQHDM = E.XZQHDM
       WHERE A.RKBZ <> '3'
             AND A.CYSJ >= D_START_DATE
             AND A.CYSJ <= D_END_DATE
       GROUP BY C.F_YEAR,
         C.F_SEASON,
         C.F_MONTH,
         C.F_WEEK,
         C.F_DAY,
         NVL(TD.F_SJQJ, '02'),
         D.XNXZQHDM,
         E.SJJGID,
         A.YLJGDMID,
         SUBSTR(D.WSJGLBDM, 1, 4),
         D.JGLSGXDM,
         SUBSTR(A.CYKSPTDM, 1, 2),
         A.ZYYSID,
         A.ZYYSGH,
         A.ZYYSXM,
         NVL(B.XB, '-'),
         DECODE(TO_CHAR(B.CSRQ, 'YYYYMMDD'),
                '19000101',
                '-1',
                TY.F_NNQJ_DM)
       UNION ALL
       SELECT
         C.F_YEAR                          AS F_YEAR,
         C.F_SEASON                        AS F_QUARTER,
         C.F_MONTH                         AS F_MONTH,
         C.F_WEEK                          AS F_WEEK,
         C.F_DAY                           AS F_DAY,
         NVL(TD.F_SJQJ, '02')              AS F_SJQJ,
         D.XNXZQHDM                        AS F_XZQX_DM,
         E.SJJGID                          AS F_SJQH_DM,
         A.YLJGDMID                        AS F_YLJG_ID,
         SUBSTR(D.WSJGLBDM, 1, 4)          AS F_YLJG_TYPE,
         D.JGLSGXDM                        AS F_YLJG_JGLSGXDM,
         NVL(SUBSTR(T.PTKSDM, 1, 2), '-1') AS F_KS_DM,
         A.SSYSID                          AS F_YS_UUID,
         A.SSYSGH                          AS F_YS_GH,
         A.SSYSXM                          AS F_YS_MC,
         B.XB                              AS F_XB,
         DECODE(TO_CHAR(B.CSRQ, 'YYYYMMDD'),
                '19000101',
                '-1',
                TY.F_NNQJ_DM)              AS F_YNDM,
         0                                 AS MZRC,
         0                                 AS MZRC_ZY,
         0                                 AS MZRC_XY,
         0                                 AS PTMZRC,
         0                                 AS PTMZRC_ZY,
         0                                 AS PTMZRC_XY,
         0                                 AS MJZRC,
         0                                 AS YYZLRC,
         0                                 AS YYZLRC_ZY,
         0                                 AS YYZLRC_XY,
         0                                 AS MZJZRC,
         0                                 AS MZJZRC_ZY,
         0                                 AS MZJZRC_XY,
         0                                 AS RYRC,
         0                                 AS RYRC_ZY,
         0                                 AS RYRC_XY,
         0                                 AS CYRC,
         0                                 AS CYRC_ZY,
         0                                 AS CYRC_XY,
         SUM(CASE
             WHEN A.XGBZ = '0' AND A.MZZYBZ IN ('1', '2')
               THEN
                 1
             WHEN A.XGBZ = '1' AND A.MZZYBZ IN ('1', '2')
               THEN
                 -1
             ELSE
               0
             END)                          AS SSRC,
         SUM(CASE
             WHEN A.XGBZ = '0' AND A.MZZYBZ = '1'
               THEN
                 1
             WHEN A.XGBZ = '1' AND A.MZZYBZ = '1'
               THEN
                 -1
             ELSE
               0
             END)                          AS SSRC_MC,
         SUM(CASE
             WHEN A.XGBZ = '0' AND A.MZZYBZ = '2'
               THEN
                 1
             WHEN A.XGBZ = '1' AND A.MZZYBZ = '2'
               THEN
                 -1
             ELSE
               0
             END)                          AS SSRC_ZY
       FROM TB_Operation_Detail A
         LEFT JOIN TB_HIS_PATINF B
           ON A.BRWYID = B.BRWYID AND a.kh = b.kh AND a.klx = b.klx
         INNER JOIN TB_DIC_SJQJ TD
           ON F_START_TIME <= TO_CHAR(A.SSKSSJ, 'HH24:MI:SS')
              AND F_END_TIME > TO_CHAR(A.SSKSSJ, 'HH24:MI:SS')
         LEFT JOIN TB_DIC_NNQJ TY
           ON F_START_NN <=
              TRUNC(MONTHS_BETWEEN(A.SSKSSJ, B.CSRQ) / 12)
              AND F_END_NN >= TRUNC(MONTHS_BETWEEN(A.SSKSSJ, B.CSRQ) / 12)
         INNER JOIN TB_DIC_DIM_DATE C
           ON TRUNC(A.SSKSSJ) = TRUNC(C.F_TODAY)
         INNER JOIN TB_DIC_WD_YLJGZDB D
           ON A.YLJGDMID = D.YLJGID
         INNER JOIN TB_DIC_WD_WSXZJGZDB E
           ON D.XNXZQHDM = E.XZQHDM
         LEFT JOIN TB_DIC_PRACTITIONER P
           ON A.SSYSID = P.RYID
         LEFT JOIN TB_DIC_DEPARTMENT T
           ON P.YLJGDM = T.YLJGDM
              AND P.SSKS = T.YYKSDM
       WHERE A.SSKSSJ >= D_START_DATE
             AND A.SSKSSJ <= D_END_DATE
       GROUP BY C.F_YEAR,
         C.F_SEASON,
         C.F_MONTH,
         C.F_WEEK,
         C.F_DAY,
         NVL(TD.F_SJQJ, '02'),
         D.XNXZQHDM,
         E.SJJGID,
         A.YLJGDMID,
         SUBSTR(D.WSJGLBDM, 1, 4),
         D.JGLSGXDM,
         SUBSTR(T.PTKSDM, 1, 2),
         A.SSYSID,
         A.SSYSGH,
         A.SSYSXM,
         B.XB,
         DECODE(TO_CHAR(B.CSRQ, 'YYYYMMDD'),
                '19000101',
                '-1',
                TY.F_NNQJ_DM)) DS
GROUP BY DS.F_YEAR,
  DS.F_QUARTER,
  DS.F_MONTH,
  DS.F_WEEK,
  DS.F_DAY,
  DS.F_SJQJ,
  DS.F_XZQX_DM,
  DS.F_SJQH_DM,
  DS.F_YLJG_ID,
  DS.F_YLJG_TYPE,
  DS.F_YLJG_JGLSGXDM,
  DS.F_KS_DM,
  DS.F_YS_UUID,
  DS.F_YS_GH,
  DS.F_YS_MC,
  NVL(DS.F_XB, '0'),
  NVL(DS.F_YNDM, '-1')