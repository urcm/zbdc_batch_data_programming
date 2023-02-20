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

gt_using_tab = value #( ( program = 'SAPMF02K' dynpro = '0101' dynbegin = 'X' fnam = '' fval = '' )
                        ( program = '' dynpro = '' dynbegin = '' fnam = 'BDC_CURSOR' fval = 'RF02K-D0110' )
                        ( program = '' dynpro = '' dynbegin = '' fnam = 'BDC_OKCODE' fval = '/00' )
                        ( program = '' dynpro = '' dynbegin = '' fnam = 'RF02K-LIFNR' fval = '300002' )
                        ( program = '' dynpro = '' dynbegin = '' fnam = 'RF02K-D0110' fval = 'X' )
                        ( program = 'SAPMF02K' dynpro = '0110' dynbegin = 'X' fnam = '' fval = '' )
                        ( program = '' dynpro = '' dynbegin = '' fnam = 'BDC_CURSOR' fval = 'RF02K-LIFNR' )
                        ( program = '' dynpro = '' dynbegin = '' fnam = 'BDC_OKCODE' fval = '/00' ) ).
