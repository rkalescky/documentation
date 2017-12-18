.. rst-class:: table 

============== ======== ===== =========== ==================================================
Partition      Duration Cores Memory [GB] Slurm Flags                                       
============== ======== ===== =========== ==================================================
development    2 hours  36    256         ``-p development``                                
htc            1 day.   1     6           ``-p htc --mem=6G``                               
standard-mem-s 1 day    36    256         ``-p standard-mem-s --exclusive --mem=250G``      
standard-mem-m 1 week   36    256         ``-p standard-mem-m --exclusive --mem=250G``      
standard-mem-l 1 month  36    256         ``-p standard-mem-l --exclusive --mem=250G``      
medium-mem-1-s 1 day    36    768         ``-p medium-mem-1-s --exclusive --mem=750G``      
medium-mem-1-m 1 week   36    768         ``-p medium-mem-1-m --exclusive --mem=750G``      
medium-mem-1-l 1 month  36    768         ``-p medium-mem-1-l --exclusive --mem=750G``      
medium-mem-2   2 weeks  24    768         ``-p medium-mem-2 --exclusive --mem=750G``        
high-mem-1     2 weeks  36    1538        ``-p high-mem-1 --exclusive --mem=1500G``         
high-mem-2     2 weeks  40    1538        ``-p high-mem-2 --exclusive --mem=1500G``         
mic            1 week   64    384         ``-p mic --exclusive --mem=374G``                 
gpgpu-1        1 week   36    256         ``-p gpgpu-1 --exclusive --gres=gpu:1 --mem=250G``
dcv            1 day    36    256         ``-p dcv --exclusive --mem=250G``                 
============== ======== ===== =========== ==================================================
