/* ----------------------------------------------------------------------
   LAMMPS - Large-scale Atomic/Molecular Massively Parallel Simulator
   http://lammps.sandia.gov, Sandia National Laboratories
   Steve Plimpton, sjplimp@sandia.gov

   Copyright (2003) Sandia Corporation.  Under the terms of Contract
   DE-AC04-94AL85000 with Sandia Corporation, the U.S. Government retains
   certain rights in this software.  This software is distributed under 
   the GNU General Public License.

   See the README file in the top-level LAMMPS directory.
------------------------------------------------------------------------- */

#ifndef FIX_DEFORM_H
#define FIX_DEFORM_H

#include "fix.h"

namespace LAMMPS_NS {

class FixDeform : public Fix {
 public:
  int remapflag;

  FixDeform(class LAMMPS *, int, char **);
  ~FixDeform();
  int setmask();
  void init();
  void pre_exchange();
  void end_of_step();

 private:
  int triclinic,scaleflag,flip;
  double *h_rate,*h_ratelo;
  int kspace_flag;                 // 1 if KSpace invoked, 0 if not
  int nrigid;                      // number of rigid fixes
  int *rfix;                       // indices of rigid fixes

  struct Set {
    int style,substyle;
    double flo,fhi,ftilt;
    double dlo,dhi,dtilt;
    double scale,vel,rate;
    double lo_start,hi_start;
    double lo_stop,hi_stop;
    double lo_target,hi_target;
    double tilt_start,tilt_stop,tilt_target;
    double vol_start,tilt_flip;
    int fixed,dynamic1,dynamic2;
  };
  Set *set;

  void options(int, char **);
};

}

#endif
