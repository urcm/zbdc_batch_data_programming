report zpro_mm01_bdc.

types: begin of gty_mara,
         matnr type rmmg1-matnr,
         maktx type makt-maktx,
         meins type mara-meins,
         matkl type mara-matkl,
         brgew type mara-brgew,
         gewei type mara-gewei,
         ntgew type mara-ntgew,
       end of gty_mara.

data: gt_mara type standard table of gty_mara,
      gs_mara like line of gt_mara.
