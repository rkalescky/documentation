.. rst-class:: table 

========================================================================================================== ======== ======= =========== ==================================================
Partition                                                                                                  Duration Cores   Memory [GB] Example Slurm Flags                                       
========================================================================================================== ======== ======= =========== ==================================================
development (1 :ref:`standard-mem <standard_nodes>`, 1 :ref:`MIC <knl_nodes>`, 1 :ref:`P100 <p100_nodes>`) 2 hours  Various Various     ``-p development``                                
:ref:`htc <standard_nodes>`                                                                                1 day.   1       6           ``-p htc --mem=6G``                               
:ref:`standard-mem-s <standard_nodes>`                                                                     1 day    36      256         ``-p standard-mem-s --mem=250G``      
:ref:`standard-mem-m <standard_nodes>`                                                                     1 week   36      256         ``-p standard-mem-m --mem=250G``      
:ref:`standard-mem-l <standard_nodes>`                                                                     1 month  36      256         ``-p standard-mem-l --mem=250G``      
:ref:`medium-mem-1-s <standard_nodes>`                                                                     1 day    36      768         ``-p medium-mem-1-s --mem=750G``      
:ref:`medium-mem-1-m <standard_nodes>`                                                                     1 week   36      768         ``-p medium-mem-1-m --mem=750G``      
:ref:`medium-mem-1-l <standard_nodes>`                                                                     1 month  36      768         ``-p medium-mem-1-l --mem=750G``      
:ref:`medium-mem-2 <standard_nodes>`                                                                       2 weeks  24      768         ``-p medium-mem-2 --mem=750G``        
:ref:`high-mem-1 <standard_nodes>`                                                                         2 weeks  36      1538        ``-p high-mem-1 --mem=1500G``         
:ref:`high-mem-2 <standard_nodes>`                                                                         2 weeks  40      1538        ``-p high-mem-2 --mem=1500G``         
:ref:`mic <knl_nodes>`                                                                                     1 week   64      384         ``-p mic --mem=374G``                 
:ref:`gpgpu-1 <p100_nodes>`                                                                                1 week   36      256         ``-p gpgpu-1 --gres=gpu:1 --mem=250G``
:ref:`fp-gpgpu-2 <fp_hagstrom>`                                                                            Various  24      128         ``-p fp-gpgpu-2 --gres=gpu:8 --mem=120G``
:ref:`fp-gpgpu-3 <fp_minsker>`                                                                             Various  40      384         ``-p fp-gpgpu-3 --gres=gpu:2 --mem=370G``
========================================================================================================== ======== ======= =========== ==================================================
