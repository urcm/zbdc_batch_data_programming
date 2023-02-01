report zbdc_verkaufer_anlegen.

types: begin of gty_vendor,
         bukrs type bukrs,
         ekorg type ekorg,
         lifnr type lifnr,
         ktokk type ktokk,
         name1 type name1,
         sortl type sortl,
         stras type stras,
         ort01 type ort01,
         land1 type land1,
         spras type spras,
         waers type waers,
       end of gty_vendor.

data: gs_bdcdata type bdcdata,
      gs_msg     type bdcmsgcoll.

data: gt_bdcdata type table of bdcdata,
      gt_bdcmsg  type table of bdcmsgcoll,
      gt_vendor  type table of gty_vendor.
      
data: lv_mode    type sy-ftype,
      lv_update  type sy-ftype,
      gs_vendor  type gty_vendor.
      
      
gs_vendor = value #( bukrs =  '0001' ekorg = '0001' lifnr = 'VENDOR9' ktokk = '0001'
                     name1 = 'BERGBAU' sortl = 'BBU' stras = 'Münchener Str.16'
                     ort01 = 'München' land1 = 'DE' spras = 'DE' waers = 'EUR'
                    ).


append gs_vendor to gt_vendor.


loop at gt_vendor into gs_vendor.

*   Screen 0100 - Field 1 - BDC Cursor
  gs_bdcdata-program = 'SAPMF02K'.
  gs_bdcdata-dynpro = '0100'.
  gs_bdcdata-dynbegin = 'X'.

  gs_bdcdata-fnam = 'BDC_CURSOR'.
  gs_bdcdata-fval = 'RF02K-LIFNR'.
  append gs_bdcdata to gt_bdcdata.
  clear gs_bdcdata.

  *   Screen 0100 - Field 2 - BDC OKCODE
  gs_bdcdata-fnam = 'BDC_OKCODE'.
  gs_bdcdata-fval = '/00'.
  append gs_bdcdata to gt_bdcdata.
  clear gs_bdcdata.

  *   Screen 0100 - Field 3 - Company Code
  gs_bdcdata-fnam = 'RF02K-BUKRS'.
  gs_bdcdata-fval = gs_vendor-bukrs.
  append gs_bdcdata to gt_bdcdata.
  clear gs_bdcdata.
  
  *   Screen 0100 - Field 4 - Purchasing Organization
  gs_bdcdata-fnam = 'RF02K-EKORG'.
  gs_bdcdata-fval = gs_vendor-ekorg.
  append gs_bdcdata to gt_bdcdata.
  clear gs_bdcdata.

*   Screen 0100 - Field 5 - Vendor
  gs_bdcdata-fnam = 'RF02K-LIFNR'.
  gs_bdcdata-fval = gs_vendor-lifnr.
  append gs_bdcdata to gt_bdcdata.
  clear gs_bdcdata.
  
  *   Screen 0100 - Field 6 - Account Group
  gs_bdcdata-fnam = 'RF02K-KTOKK'.
  gs_bdcdata-fval = gs_vendor-ktokk.
  append gs_bdcdata to gt_bdcdata.
  clear gs_bdcdata.

**********************************************************************

*   Screen 0110 - Field 1 - BDC Cursor
  gs_bdcdata-program = 'SAPMF02K'.
  gs_bdcdata-dynpro = '0310'.
  gs_bdcdata-dynbegin = 'X'.

  gs_bdcdata-fnam = 'BDC_CURSOR'.
  gs_bdcdata-fval = 'LFM1-WAERS'.
  append gs_bdcdata to gt_bdcdata.
  clear gs_bdcdata.
  
  *   Screen 0110 - Field 2 - BDC OKCODE
  gs_bdcdata-fnam = 'BDC_OKCODE'.
  gs_bdcdata-fval = '=UPDA'.
  append gs_bdcdata to gt_bdcdata.
  clear gs_bdcdata.
  
  *   Screen 0110 - Field 3 - Order Currency
  gs_bdcdata-fnam = 'LFM1-WAERS'.
  gs_bdcdata-fval = gs_vendor-waers.
  append gs_bdcdata to gt_bdcdata.
  clear gs_bdcdata.

endloop.
