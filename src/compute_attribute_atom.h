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

#ifndef COMPUTE_ATTRIBUTE_ATOM_H
#define COMPUTE_ATTRIBUTE_ATOM_H

#include "compute.h"

namespace LAMMPS_NS {

class ComputeAttributeAtom : public Compute {
 public:
  ComputeAttributeAtom(class LAMMPS *, int, char **);
  ~ComputeAttributeAtom();
  void init() {}
  void compute_peratom();
  int memory_usage();

 private:
  int which,allocate,nmax;
  double *s_attribute,**v_attribute;
};

}

#endif
