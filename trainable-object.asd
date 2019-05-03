(defsystem trainable-object
  :version "0.1"
  :author "Masataro Asai"
  :mailto "guicho2.71828@gmail.com"
  :license "LGPL"
  :defsystem-depends-on ()
  :depends-on (:closer-mop :serializable-object)
  :pathname "src"
  :components ((:file "package"))
  :description "Provides a metaclass and APIs for the trainable funcallable instances."
  :in-order-to ((test-op (test-op :trainable-object.test)))
  ;; :defsystem-depends-on (:trivial-package-manager)
  ;; :perform
  #+(or)
  (load-op :before (op c)
           (uiop:symbol-call :trivial-package-manager
                             :ensure-program
                             "minisat"
                             :apt "minisat"
                             :dnf "minisat2"
                             :yum "minisat2"
                             :packman ""
                             :yaourt ""
                             :brew "minisat"
                             :choco ""
                             :from-source (format nil "make -C ~a"
                                                  (asdf:system-source-directory :trainable-object)))
           (uiop:symbol-call :trivial-package-manager
                             :ensure-library
                             "libfixposix"
                             :apt "libfixposix0"
                             :dnf ""
                             :yum ""
                             :packman ""
                             :yaourt ""
                             :brew "libfixposix"
                             :choco ""
                             :from-source (format nil "make -C ~a"
                                                  (asdf:system-source-directory :trainable-object)))))
