!==================================================================
! Command Line Interface (Footer file)
!
! Created by: Hisashi Takeda, Ph.D. 2019-01-19
!==================================================================

module subroutine get_character (str, i_arg)

  character(*), intent(inout) :: str
  integer     , intent(inout) :: i_arg

  i_arg = i_arg + 1

  call get_command_argument ( i_arg, arg, status = status )

  if ( status /= 0 ) print *, 'Error', status, 'on argument', i_arg

  str = trim(arg)

  !print '(a, i2, a)', 'Arg', i_arg / 2, ': '//trim(str)

end subroutine

module subroutine get_integer (ival, i_arg)

  integer, intent(inout) :: ival
  integer, intent(inout) :: i_arg

  i_arg = i_arg + 1

  call get_command_argument ( i_arg, arg, status = status )

  if ( status /= 0 ) print *, 'Error', status, 'on argument', i_arg

  read (arg, *) ival

  !print '(a, i2, a, i0)', 'Arg', i_arg / 2, ': ', ival

end subroutine

module subroutine get_real (rval, i_arg)

  real(8), intent(inout) :: rval
  integer, intent(inout) :: i_arg

  i_arg = i_arg + 1

  call get_command_argument ( i_arg, arg, status = status )

  if ( status /= 0 ) print *, 'Error', status, 'on argument', i_arg

  read (arg, *) rval

  !print '(a, i2, a, g0)', 'Arg', i_arg / 2, ': ', rval

end subroutine

module subroutine get_logical (ox, i_arg)

  logical, intent(inout) :: ox
  integer, intent(inout) :: i_arg

  i_arg = i_arg + 1

  call get_command_argument ( i_arg, arg, status = status )

  if ( status /= 0 ) print *, 'Error', status, 'on argument', i_arg

  read ( arg, * ) ox
  
  !print '(a, i2, a, l)', 'Arg', i_arg / 2, ': ', ox

end subroutine

function get_date_time() result(date_time)

  character(19) :: date_time
  character(8)  :: date
  character(10) :: time
  character(5)  :: zone

  call date_and_time (DATE=date, TIME = time, ZONE = zone)

  write (date_time, '(a4, "-", a2, "-", a2, " ", a2, ":", a2)') &
    date(1:4), date(5:6), date(7:8), time(1:2), time(3:4)

end function

subroutine print_help (this)

  class(cmd_ty), intent(in) :: this
  integer j

  print '(a)', ''
  print '(a)', repeat('=', 80)
  print '(a)', trim(cmd%title)
  print '(a)', repeat('-', 80)

  do j = 1, this%n_usage
    print *, trim(this%usage(j))
  end do

  print '(a)', repeat('=', 80)

  stop

end subroutine

subroutine print_version (this, date_time)

  class(cmd_ty), intent(in) :: this
  character(*),  intent(in) :: date_time

  print '(a)', 'Executable file: '//trim(this%exe)
  print '(a)', 'Version '//trim(this%version)
  print '(a)', 'Created by '// trim(this%author)
  print '(a)', '2011 '//trim(this%copyright)
  print '(a)', repeat('=', 80)
  print '(a)', trim(date_time)

  stop

end subroutine

!program unit_test
!
!  use cli_mo
!
!  implicit none
!
!  type(cmd_ty) :: cmd
!
!  character(255) :: cval = 'test.csv'
!  integer        :: ival = 2
!  real(8)        :: rval = 3.d0
!  logical        :: lval = .true.
!  integer        :: i = 1
!
!  cmd%exe      = 'Executable_file_name'
!  cmd%version  = '1.0'
!  cmd%usage(i) = 'Usage: '//trim(cmd%exe)//' [OPTIONS]                       ';i=i+1
!  cmd%usage(i) = '                                                           ';i=i+1
!  cmd%usage(i) = 'Example: '//trim(cmd%exe)//' -c file.csv -i 4 -r 4.d0, -l F';i=i+1
!  cmd%usage(i) = '                                                           ';i=i+1
!  cmd%usage(i) = 'Program options:                                           ';i=i+1
!  cmd%usage(i) = '                                                           ';i=i+1
!  cmd%usage(i) = '  -c --cval followed by character string                   ';i=i+1
!  cmd%usage(i) = '  -i --ival followed by integer value                      ';i=i+1
!  cmd%usage(i) = '  -r --rval followed by real value                         ';i=i+1
!  cmd%usage(i) = '  -l --lval followed by boolean value                      ';i=i+1
!  cmd%usage(i) = '  -v, --version print version information and exit         ';i=i+1
!  cmd%usage(i) = '  -h, --help    print usage information and exit           ';i=i+1
!  cmd%usage(i) = '                                                           ';i=i+1
!  cmd%n_usage  = i - 1
!
!  call cmd%get_args (cval, ival, rval, lval)
!
!end program
