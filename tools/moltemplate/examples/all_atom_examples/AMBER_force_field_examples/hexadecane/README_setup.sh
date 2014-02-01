# -------- REQUIREMENTS: ---------
#  You must define your MOLTEMPLATE_PATH environment variable
#  and set it to the "common" subdirectory of your moltemplate distribution.
#  (See the "Installation" section in the moltemplate manual.)


# Create LAMMPS input files this way:
cd moltemplate_files

  # run moltemplate

  moltemplate.sh system.lt

  # This will generate various files with names ending in *.in* and *.data. 
  # These files are the input files directly read by LAMMPS.  Move them to 
  # the parent directory (or wherever you plan to run the simulation).
  #cp -f system.data system.in* ../


  # --------- OPTIONAL STEPS FOR STRIPPING OUT JUNK ---------
  # --------- edit 2013-10-13 ---------
  echo "-----------------------------------------------------------------" >&2
  echo "OPTIONAL STEP: PRUNING THE RESULTING MOLTEMPLATE OUTPUT TO" >&2
  echo "               INCLUDE ONLY ATOMS AND TYPES WE ARE ACTUALLY USING." >&2
  # Unfortunately, as of 2013-8-28, these files contain a lot of irrelevant
  # information (for atom types not present in the current system).
  # For now, we can strip this out using ltemplify.py to build a new .lt file.
  # THIS IS AN UGLY WORKAROUND. HOPEFULLY IN THE FUTURE, WE CAN SKIP THESE STEPS

  # do this in a temporary_directory
  mkdir new_lt_file
  cd new_lt_file/

  # now run ltemplify.py

  ltemplify.py ../system.in.init ../system.in.settings ../system.data > system.lt
  rm -rf ../system.data ../system.in*  # these old lammps files no longer needed

  # This creates a new .LT file named "system.lt" in the local directory.


  # The ltemplify.py script also does not copy the boundary dimensions.
  # We must do this manually.
  echo "write_once(\"Data Boundary\") {" >> system.lt
  cat "../output_ttree/Data Boundary" >> system.lt
  echo "}" >> system.lt
  echo "" >> system.lt
  # Now, run moltemplate on this new .LT file.
  moltemplate.sh system.lt
  # This will create: "system.data" "system.in.init" "system.in.settings."


  # Move the final DATA and INput scripts to the desired location,
  mv -f system.data system.in* ../../

  # and clean up the mess
  rm -rf output_ttree/
  cd ..
  rm -rf new_lt_file/
  echo "---------------- DONE PRUNING MOLTEMPLATE OUTPUT ----------------" >&2
  echo "-----------------------------------------------------------------" >&2
  # --------- END OF OPTIONAL STEPS FOR STRIPPING OUT JUNK ---------




  # Optional:
  # The "./output_ttree/" directory is full of temporary files generated by 
  # moltemplate.  They can be useful for debugging, but are usually thrown away.
  rm -rf output_ttree/



cd ../
