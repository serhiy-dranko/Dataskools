EXTRACT
  Source:         Mockaroo (simulated German retail transactions)
  Format:         CSV
  Volume:         1000 rows
  Issues found:   

                Row	Column 	Original Value 	New Value 	Rule Applied 	Fixed By
                81	city	berlin	Berlin	Find & Replace (Ctrl+H)	Serhiy Dranko
                94	city	berlin	Berlin	Find & Replace (Ctrl+H)	Serhiy Dranko
                103	city	berlin	Berlin	Find & Replace (Ctrl+H)	Serhiy Dranko
                139	city	MÜNCHEN	München	Find & Replace (Ctrl+H)	Serhiy Dranko
                215	city	MÜNCHEN	München	Find & Replace (Ctrl+H)	Serhiy Dranko
                5	quantity	0	1	Find & Replace (Ctrl+H)	Serhiy Dranko
                23	quantity	-1	1	Find & Replace (Ctrl+H)	Serhiy Dranko
                89	quantity	0	1	Find & Replace (Ctrl+H)	Serhiy Dranko
                224	unit_price_eur	0		Find & Replace (Ctrl+H)	Serhiy Dranko
                278	unit_price_eur	0		Find & Replace (Ctrl+H)	Serhiy Dranko
                11	satisfaction_score		3	AVERAGE by city	Serhiy Dranko
                71	satisfaction_score		3	AVERAGE by city	Serhiy Dranko
                89	satisfaction_score		3	AVERAGE by city	Serhiy Dranko
                163	satisfaction_score		3	AVERAGE by city	Serhiy Dranko

TRANSFORM
  Tool used:      Google Sheets
  Cleaning done:  Find & Replace mistakes and empty data
  New fields:     total_revenue_eur, data_quality_flag
  Aggregations:   Revenue by city, returns by city, product performance, payment breakdown

LOAD
  Destination:    Google Sheets dashboard
  Consumers:      Store manager / business analyst
  Refresh:        Manual (in production: scheduled)
