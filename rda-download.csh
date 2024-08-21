#!/usr/bin/env csh
#
# c-shell script to download selected files from rda.ucar.edu using Wget
# NOTE: if you want to run under a different shell, make sure you change
#       the 'set' commands according to your shell's syntax
# after you save the file, don't forget to make it executable
#   i.e. - "chmod 755 <name_of_script>"
#
# Experienced Wget Users: add additional command-line flags to 'opts' here
#   Use the -r (--recursive) option with care
#   Do NOT use the -b (--background) option - simultaneous file downloads
#       can cause your data access to be blocked
set opts = "-N"
#
# Check wget version.  Set the --no-check-certificate option 
# if wget version is 1.10 or higher
set v = `wget -V |grep 'GNU Wget ' | cut -d ' ' -f 3`
set a = `echo $v | cut -d '.' -f 1`
set b = `echo $v | cut -d '.' -f 2`
if(100 * $a + $b > 109) then
  set cert_opt = "--no-check-certificate"
else
  set cert_opt = ""
endif

set filelist= ( \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f000.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f003.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f006.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f009.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f012.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f015.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f018.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f021.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f024.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f027.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f030.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f033.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f036.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f039.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f042.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f045.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f048.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f051.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f054.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f057.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f060.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f063.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f066.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f069.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f072.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f075.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f078.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f081.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f084.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f087.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f090.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f093.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f096.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f099.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f102.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f105.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f108.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f111.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f114.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f117.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f120.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f123.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f126.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f129.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f132.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f135.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f138.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f141.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f144.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f147.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f150.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f153.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f156.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f159.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f162.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f165.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f168.grib2  \
  https://data.rda.ucar.edu/d084001/2024/20240815/gfs.0p25.2024081500.f171.grib2  \
)
while($#filelist > 0)
  set syscmd = "wget $cert_opt $opts $filelist[1]"
  echo "$syscmd ..."
  $syscmd
  shift filelist
end
