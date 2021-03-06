dnl Configure paths for DVDREAD
dnl
dnl Copyright (C) 2001 Daniel Caujolle-Bert <segfault@club-internet.fr>
dnl  
dnl This program is free software; you can redistribute it and/or modify
dnl it under the terms of the GNU General Public License as published by
dnl the Free Software Foundation; either version 2 of the License, or
dnl (at your option) any later version.
dnl  
dnl This program is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl GNU General Public License for more details.
dnl  
dnl You should have received a copy of the GNU General Public License
dnl along with this program; if not, write to the Free Software
dnl Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
dnl  
dnl  
dnl As a special exception to the GNU General Public License, if you
dnl distribute this file as part of a program that contains a configuration
dnl script generated by Autoconf, you may include it under the same
dnl distribution terms that you use for the rest of that program.
dnl  

dnl AM_PATH_DVDREAD([MINIMUM-VERSION, [ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND ]]])
dnl Test for DVDREAD, and define DVDREAD_CFLAGS and DVDREAD_LIBS
dnl
AC_DEFUN([AM_PATH_DVDREAD],
[dnl 
dnl Get the cflags and libraries from the dvdread-config script
dnl
AC_ARG_WITH(dvdread-prefix,
    AC_HELP_STRING([--with-dvdread-prefix=DIR], [prefix where DVDREAD is installed (optional)]),
            dvdread_config_prefix="$withval", dvdread_config_prefix="")
AC_ARG_WITH(dvdread-exec-prefix,
    AC_HELP_STRING([--with-dvdread-exec-prefix=DIR], [exec prefix where DVDREAD is installed (optional)]),
            dvdread_config_exec_prefix="$withval", dvdread_config_exec_prefix="")
AC_ARG_ENABLE(dvdreadtest, 
    AC_HELP_STRING([--disable-dvdreadtest], [do not try to compile and run a test DVDREAD program]),
            enable_dvdreadtest=$enableval, enable_dvdreadtest=yes)

  if test x$dvdread_config_exec_prefix != x ; then
     dvdread_config_args="$dvdread_config_args --exec-prefix=$dvdread_config_exec_prefix"
     if test x${DVDREAD_CONFIG+set} != xset ; then
        DVDREAD_CONFIG=$dvdread_config_exec_prefix/bin/dvdread-config
     fi
  fi
  if test x$dvdread_config_prefix != x ; then
     dvdread_config_args="$dvdread_config_args --prefix=$dvdread_config_prefix"
     if test x${DVDREAD_CONFIG+set} != xset ; then
        DVDREAD_CONFIG=$dvdread_config_prefix/bin/dvdread-config
     fi
  fi

  min_dvdread_version=ifelse([$1], ,0.0.0,$1)
  if test "x$enable_dvdreadtest" != "xyes" ; then
    AC_MSG_CHECKING([for DVDREAD-LIB version >= $min_dvdread_version])
  else
    AC_PATH_PROG(DVDREAD_CONFIG, dvdread-config, no)
    AC_MSG_CHECKING([for DVDREAD-LIB version >= $min_dvdread_version])
    no_dvdread=""
    if test "$DVDREAD_CONFIG" = "no" ; then
      no_dvdread=yes
    else
      DVDREAD_CFLAGS=`$DVDREAD_CONFIG $dvdread_config_args --cflags`
      DVDREAD_LIBS=`$DVDREAD_CONFIG $dvdread_config_args --libs`
      dvdread_config_major_version=`$DVDREAD_CONFIG $dvdread_config_args --version | \
             sed 's/\([[0-9]]*\).\([[0-9]]*\).\([[0-9]]*\)/\1/'`
      dvdread_config_minor_version=`$DVDREAD_CONFIG $dvdread_config_args --version | \
             sed 's/\([[0-9]]*\).\([[0-9]]*\).\([[0-9]]*\)/\2/'`
      dvdread_config_sub_version=`$DVDREAD_CONFIG $dvdread_config_args --version | \
             sed 's/\([[0-9]]*\).\([[0-9]]*\).\([[0-9]]*\)/\3/'`
      dnl    if test "x$enable_dvdreadtest" = "xyes" ; then
      ac_save_CFLAGS="$CFLAGS"
      ac_save_LIBS="$LIBS"
      CFLAGS="$CFLAGS $DVDREAD_CFLAGS"
      LIBS="$DVDREAD_LIBS $LIBS"
dnl
dnl Now check if the installed DVDREAD is sufficiently new. (Also sanity
dnl checks the results of dvdread-config to some extent
dnl
      AC_LANG_SAVE()
      AC_LANG_C()
      rm -f conf.dvdreadtest
      AC_TRY_RUN([
#include <dvdread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int 
main ()
{
  int major, minor, sub;
   char *tmp_version;

  system ("touch conf.dvdreadtest");

  /* HP/UX 9 (%@#!) writes to sscanf strings */
  tmp_version = (char *) strdup("$min_dvdread_version");
  if (sscanf(tmp_version, "%d.%d.%d", &major, &minor, &sub) != 3) {
     printf("%s, bad version string\n", "$min_dvdread_version");
     exit(1);
   }

  if (($dvdread_config_major_version > major) ||
     (($dvdread_config_major_version == major) && ($dvdread_config_minor_version > minor)) ||
     (($dvdread_config_major_version == major) && ($dvdread_config_minor_version == minor) && ($dvdread_config_sub_version >= sub))) {
    return 0;
  } else {
    printf("\n*** An old version of libdvdread (%d.%d.%d) was found.\n",
      $dvdread_config_major_version, $dvdread_config_minor_version, $dvdread_config_sub_version);
    printf("*** You need a version of libdvdread newer than %d.%d.%d. The latest version of\n",
      major, minor, sub);
    printf("*** libdvdread is always available from:\n");
    printf("***        http://dvd.sourceforge.net\n");
    printf("***\n");
    printf("*** If you have already installed a sufficiently new version, this error\n");
    printf("*** probably means that the wrong copy of the dvdread-config shell script is\n");
    printf("*** being found. The easiest way to fix this is to remove the old version\n");
    printf("*** of libdvdread, but you can also set the DVDREAD_CONFIG environment to point to the\n");
    printf("*** correct copy of dvdread-config. (In this case, you will have to\n");
    printf("*** modify your LD_LIBRARY_PATH enviroment variable, or edit /etc/ld.so.conf\n");
    printf("*** so that the correct libraries are found at run-time))\n");
  }
  return 1;
}
],, no_dvdread=yes,[echo $ac_n "cross compiling; assumed OK... $ac_c"])
       CFLAGS="$ac_save_CFLAGS"
       LIBS="$ac_save_LIBS"
     fi
    fi
    if test "x$no_dvdread" = x ; then
       AC_MSG_RESULT(yes)
       ifelse([$2], , :, [$2])     
    else
      AC_MSG_RESULT(no)
      if test "$DVDREAD_CONFIG" = "no" ; then
        echo "*** The dvdread-config script installed by DVDREAD could not be found"
        echo "*** If DVDREAD was installed in PREFIX, make sure PREFIX/bin is in"
        echo "*** your path, or set the DVDREAD_CONFIG environment variable to the"
        echo "*** full path to dvdread-config."
      else
        if test -f conf.dvdreadtest ; then
          :
        else
          echo "*** Could not run DVDREAD test program, checking why..."
          CFLAGS="$CFLAGS $DVDREAD_CFLAGS"
          LIBS="$LIBS $DVDREAD_LIBS"
          AC_TRY_LINK([
#include <dvdread.h>
#include <stdio.h>
],      [ return 0; ],
        [ echo "*** The test program compiled, but did not run. This usually means"
          echo "*** that the run-time linker is not finding DVDREAD or finding the wrong"
          echo "*** version of DVDREAD. If it is not finding DVDREAD, you'll need to set your"
          echo "*** LD_LIBRARY_PATH environment variable, or edit /etc/ld.so.conf to point"
          echo "*** to the installed location  Also, make sure you have run ldconfig if that"
          echo "*** is required on your system"
	  echo "***"
          echo "*** If you have an old version installed, it is best to remove it, although"
          echo "*** you may also be able to get things to work by modifying LD_LIBRARY_PATH"
          echo "***"],
        [ echo "*** The test program failed to compile or link. See the file config.log for the"
          echo "*** exact error that occured. This usually means DVDREAD was incorrectly installed"
          echo "*** or that you have moved DVDREAD since it was installed. In the latter case, you"
          echo "*** may want to edit the dvdread-config script: $DVDREAD_CONFIG" ])
          CFLAGS="$ac_save_CFLAGS"
          LIBS="$ac_save_LIBS"
        fi
      fi
    DVDREAD_CFLAGS=""
    DVDREAD_LIBS=""
    ifelse([$3], , :, [$3])
  fi
  AC_SUBST(DVDREAD_CFLAGS)
  AC_SUBST(DVDREAD_LIBS)
  AC_LANG_RESTORE()
  rm -f conf.dvdreadtest
])
