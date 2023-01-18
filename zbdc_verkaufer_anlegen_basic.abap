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
