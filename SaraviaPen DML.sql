USE SaraviaPen

select * from salesTransaction
INSERT INTO salesTransaction VALUES('SLT016', 'CTR006' , 'STF006' , 'Debit' , '2020-12-29')
INSERT INTO salesTransaction VALUES('SLT017', 'CTR007' , 'STF007' , 'Cash' , '2020-12-30')

INSERT INTO purchaseTransaction VALUES('PCT016', 'VDR006' , 'STF006' , 'E-Money' , '2020-12-23')
INSERT INTO purchaseTransaction VALUES('PCT017', 'VDR007' , 'STF007' , 'Credit' , '2020-12-25')

INSERT INTO salesDetail VALUES('SLT026', 'PEN006' , '49' , '25')
INSERT INTO salesDetail VALUES('SLT027', 'PEN007' , '39' , '28')

INSERT INTO purchaseDetail VALUES('PCT026', 'PEN006' , '49' , '18')
INSERT INTO purchaseDetail VALUES('PCT027', 'PEN007' , '82' , '58')
