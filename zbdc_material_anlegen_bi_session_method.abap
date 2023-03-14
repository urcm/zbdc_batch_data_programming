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
      
loop at gt_mara into gs_mara.

    refresh: messtab, bdcdata.

    perform bdc_dynpro      using 'SAPLMGMM' '0060'.
    perform bdc_field       using 'BDC_CURSOR'
                                  'RMMG1-MATNR'.
    perform bdc_field       using 'BDC_OKCODE'
                                  '=ENTR'.
    perform bdc_field       using 'RMMG1-MATNR'
                                  gs_mara-matnr.    "'ZMADM'.
                                  
                                  
    perform bdc_field       using 'RMMG1-MBRSH'
                                  'M'.
    perform bdc_field       using 'RMMG1-MTART'
                                  'FHMI'.
    perform bdc_dynpro      using 'SAPLMGMM' '0070'.
    perform bdc_field       using 'BDC_CURSOR'
                                  'MSICHTAUSW-DYTXT(04)'.
    perform bdc_field       using 'BDC_OKCODE'
                                  '=ENTR'.     
                                  
    perform bdc_field       using 'RMMG1-MBRSH'
                                  'M'.
    perform bdc_field       using 'RMMG1-MTART'
                                  'FHMI'.
    perform bdc_dynpro      using 'SAPLMGMM' '0070'.
    perform bdc_field       using 'BDC_CURSOR'
                                  'MSICHTAUSW-DYTXT(04)'.
    perform bdc_field       using 'BDC_OKCODE'
                                  '=ENTR'.           
                                  
    perform bdc_field       using 'MSICHTAUSW-KZSEL(01)'
                                  'X'.
    perform bdc_field       using 'MSICHTAUSW-KZSEL(02)'
                                  'X'.
    perform bdc_field       using 'MSICHTAUSW-KZSEL(04)'
                                  'X'.
    perform bdc_dynpro      using 'SAPLMGMM' '0080'.
    perform bdc_field       using 'BDC_CURSOR'
                                  'RMMG1-WERKS'.
    perform bdc_field       using 'BDC_OKCODE'
                                  '=ENTR'.
                                  
    perform bdc_field       using 'RMMG1-WERKS'
                                  'ZM03'.
    perform bdc_dynpro      using 'SAPLMGMM' '4004'.
    perform bdc_field       using 'BDC_OKCODE'
                                  '/00'.
    perform bdc_field       using 'MAKT-MAKTX'
                                  gs_mara-maktx.  "'Staubsauger Roboter'.          
                                  
     perform bdc_field       using 'MARA-MEINS'
                                  gs_mara-meins.  "'EA'.
    perform bdc_field       using 'MARA-MATKL'
                                  gs_mara-matkl.  "'01'.
    perform bdc_field       using 'BDC_CURSOR'
                                  'MARA-GEWEI'.
    perform bdc_field       using 'MARA-BRGEW'
                                  gs_mara-brgew.  "'4,65'.
    perform bdc_field       using 'MARA-GEWEI'
                                  gs_mara-gewei.  "'KG'.
                                  
    perform bdc_field       using 'MARA-NTGEW'
                                  gs_mara-ntgew.  "'4,50'.
    perform bdc_dynpro      using 'SAPLMGMM' '4004'.
    perform bdc_field       using 'BDC_OKCODE'
                                  '/00'.
    perform bdc_field       using 'BDC_CURSOR'
                                  'MAKT-MAKTX'.
    perform bdc_field       using 'MAKT-MAKTX'
                                  gs_mara-maktx.  "'Staubsauger Roboter'.                                
                                  
    perform bdc_dynpro      using 'SAPLMGMM' '4000'.
    perform bdc_field       using 'BDC_OKCODE'
                                  '/00'.
    perform bdc_field       using 'BDC_CURSOR'
                                  'MAKT-MAKTX'.
    perform bdc_field       using 'MAKT-MAKTX'
                                  gs_mara-maktx.  "'Staubsauger Roboter'..
    perform bdc_field       using 'MARA-MEINS'
                                  gs_mara-meins.  "'EA'.
    perform bdc_field       using 'MARA-MATKL'
                                  gs_mara-matkl.  "'01'.
    perform bdc_dynpro      using 'SAPLSPO1' '0300'.
    perform bdc_field       using 'BDC_OKCODE'
                                  '=YES'.            
                                  
    call function 'BDC_INSERT'
      exporting
        tcode     = 'MM01'
      tables
        dynprotab = bdcdata.

    clear: gs_mara.
  endloop.

  call function 'BDC_CLOSE_GROUP'
    exceptions
      not_open    = 1
      queue_error = 2
      others      = 3.
  if sy-subrc eq 0.
    message 'BDC Mappe wurde angelegt' type 'I'.
  else.
    message 'BDC Mappe wurde nicht angelegt' type 'I'.
  endif.

form bdc_dynpro using program dynpro.
  clear bdcdata.
  bdcdata-program  = program.
  bdcdata-dynpro   = dynpro.
  bdcdata-dynbegin = 'X'.
  append bdcdata.
endform.

form bdc_field using fnam fval.
  if fval <> space.
    clear bdcdata.
    bdcdata-fnam = fnam.
    bdcdata-fval = fval.
    shift bdcdata-fval left deleting leading space.
    append bdcdata.
  endif.
endform.
