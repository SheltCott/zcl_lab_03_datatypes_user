CLASS zcl_lab_03_datatypes_user DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

    DATA: mv_char      TYPE c LENGTH 10 VALUE '12345',
          mv_num       TYPE i,
          mv_float     TYPE f,
          mv_trunc     TYPE i,
          mv_round     TYPE i,
          mv_date_1    TYPE d,
          mv_date_2    TYPE d,
          mv_days      TYPE i,
          mv_time      TYPE t,
          mv_timestamp TYPE utclong.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_lab_03_datatypes_user IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
*     Type Conversions
    me->mv_num = me->mv_char.
    me->mv_float = me->mv_num.

    out->write( |{ me->mv_char }| ).
    out->write( |{ me->mv_num }| ).
    out->write( |{ me->mv_float }| ).

*     Truncation and Rounding
    me->mv_float = '123.45'.
    me->mv_trunc = trunc( me->mv_float ).
    me->mv_float = me->mv_float + '0.5'.
    me->mv_round = me->mv_float.

    out->write( |{ me->mv_trunc }| ).
    out->write( |{ me->mv_round }| ).

*     Inline Type Declarations
    DATA(lv_inline) = 'ABAP'.
    out->write( |{ lv_inline }| ).

*     Forced Type Conversions
    me->mv_num = CONV i( me->mv_char ).
    out->write( |{ me->mv_num }| ).

*     Date and Time Calculation
    me->mv_date_1 = '20240101'.
    me->mv_date_2 = '20240115'.

    me->mv_days = me->mv_date_2 - me->mv_date_1.

    out->write( |{ me->mv_date_1+6(2) }/{ me->mv_date_1+4(2) }/{ me->mv_date_1(4) }| ). " format DDMMYYYY
    out->write( |{ me->mv_date_2 }| ).
    out->write( |{ me->mv_days }| ).

*     Timestamp Fields
    me->mv_timestamp = utclong_current( ).

    TRY.
        CONVERT UTCLONG me->mv_timestamp    " Convert timestamp to date and time
        TIME ZONE cl_abap_context_info=>get_user_time_zone(  )
        INTO DATE me->mv_date_2
        TIME me->mv_time.
      CATCH cx_abap_context_info_error INTO DATA(lv_error).
        out->write( lv_error ).
    ENDTRY.

    out->write( |{ me->mv_timestamp }| ).
    out->write( |{ me->mv_date_2 }| ).
    out->write( |{ me->mv_time }| ).

    me->mv_timestamp = utclong_add( val = me->mv_timestamp days = -2  ). " Subtract 2 years from the date
    out->write( |{ me->mv_date_2 }| ).
  ENDMETHOD.
ENDCLASS.