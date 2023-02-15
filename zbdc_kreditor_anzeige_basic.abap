*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(TCODE) LIKE  SY-TCODE
*"     VALUE(SKIP_SCREEN) LIKE  SY-FTYPE DEFAULT SPACE
*"     VALUE(MODE_VAL) LIKE  SY-FTYPE DEFAULT 'A'
*"     VALUE(UPDATE_VAL) LIKE  SY-FTYPE DEFAULT 'A'
*"  EXPORTING
*"     VALUE(SUBRC) LIKE  SY-SUBRC
*"  TABLES
*"      USING_TAB STRUCTURE  BDCDATA OPTIONAL
*"      SPAGPA_TAB STRUCTURE  RFC_SPAGPA OPTIONAL
*"      MESS_TAB STRUCTURE  BDCMSGCOLL OPTIONAL
*"  EXCEPTIONS
*"      CALL_TRANSACTION_DENIED
*"      TCODE_INVALID
*"----------------------------------------------------------------------


data: gt_using_tab type standard table of bdcdata.
data: gt_mess_tab type standard table of bdcmsgcoll.
