!==================================================================
! Command Line Interface (Header file)
!
! Created by: Hisashi Takeda, Ph.D. 2019-01-19
!==================================================================

implicit none

private

public :: cmd_ty, cmd, i

integer :: idummy
real(8) :: rdummy
logical :: ldummy

character(255) :: cwd, arg
character(19)  :: date_time
integer        :: status, i_arg = 1

type cmd_ty

character(255) :: title      = 'Program title'
character(255) :: exe        = 'Executable_file_name'
character(255) :: version    = '1.0'
character(255) :: author     = 'Hisashi Takeda, Ph.D.'
character(255) :: copyright  = 'Copyright(C) All Rights Reserved.'
character(255) :: usage(200) = 'No usage is given'
integer        :: n_usage    = 1

contains

procedure get_args
procedure print_help
procedure print_version

end type

type(cmd_ty) :: cmd
integer      :: i = 1

interface get_value

module subroutine get_character (str, i_arg)
  character(*), intent(inout) :: str
  integer     , intent(inout) :: i_arg
end subroutine

module subroutine get_integer (ival, i_arg)
  integer, intent(inout) :: ival
  integer, intent(inout) :: i_arg
end subroutine

module subroutine get_real (rval, i_arg)
  real(8), intent(inout) :: rval
  integer, intent(inout) :: i_arg
end subroutine

module subroutine get_logical (ox, i_arg)
  logical, intent(inout) :: ox
  integer, intent(inout) :: i_arg
end subroutine

end interface
