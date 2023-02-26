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
      
data: gv_filename type string.

data:   bdcdata like bdcdata    occurs 0 with header line,
        messtab like bdcmsgcoll occurs 0 with header line.

parameters: p_file like rlgrap-filename obligatory.

at selection-screen on value-request for p_file.

  CALL FUNCTION 'KD_GET_FILENAME_ON_F4'
    EXPORTING
      static    = 'X'
    CHANGING
      file_name = p_file.

start-of-selection.

  gv_filename = p_file.
  
  call function 'GUI_UPLOAD'
    exporting
      filename            = gv_filename
      filetype            = 'ASC'
      has_field_separator = 'X'
    tables
      data_tab            = gt_mara.

  cl_demo_output=>display( gt_mara ).
  
call function 'BDC_OPEN_GROUP'
    exporting
      client = sy-mandt
      group  = 'ZMM0102030'
      keep   = 'X'
      user   = sy-uname
      prog   = sy-cprog.
