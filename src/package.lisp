#|

This file is a part of TRAINABLE-OBJECT project.
Copyright (c) 2019 Masataro Asai (guicho2.71828@gmail.com)
Copyright (c) 2019 IBM Corporation
SPDX-License-Identifier: LGPL-3.0-or-later

TRAINABLE-OBJECT is free software: you can redistribute it and/or modify it under the terms
of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any
later version.

TRAINABLE-OBJECT is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
TRAINABLE-OBJECT.  If not, see <http://www.gnu.org/licenses/>.

Copyright (c) 2019 Masataro Asai (guicho2.71828@gmail.com)
Copyright (c) 2019 IBM Corporation

|#

(in-package :cl-user)
(uiop:define-package trainable-object
    (:mix :closer-mop :cl)
    (:use :serializable-object)
    (:reexport :serializable-object)
    (:export
     trainable-object
     train-accuracy
     val-accuracy
     test-accuracy
     train
     evaluate
     predict
     compose
     logical-form
     classifier
     binary-classifier
     #:classes))
(in-package :trainable-object)

;; blah blah blah.

(defclass trainable-object (serializable-object)
  ()
  (:documentation "
It represents a function-like object that is trainable from data,
and is serializable so that it can save its learned parameters.
 "))

(defgeneric train    (model input output &key verbose val-input val-output test-input test-output &allow-other-keys)
  (:documentation "
Train a model using the input / output.
INPUT / OUTPUT could be a list, if the model has multiple inputs / outputs.


When BATCH is non-nil, it assumes a batch (multiple data points) input.
The responsibility for handling this parameter properly belongs to each method.
In general, when BATCH is an INTEGER value, it is assumed to be the batch processing size.

"))
(defgeneric evaluate (model input output &key verbose &allow-other-keys)
  (:documentation "
Evaluate a model, i.e., compute the loss/score function for the ground truth output and the predicted output.
"))
(defgeneric predict  (model input        &key verbose &allow-other-keys)
  (:documentation "
Predict the output using a model.
"))

(defgeneric logical-form  (model &key &allow-other-keys)
  (:documentation "
A generic function that returns a symbolic logical form that corresponds to the machine learning model.
Not all ML model has a method for this function.
"))

(defmethod evaluate :around ((m trainable-object) input output &key verbose &allow-other-keys)
  (let ((score (call-next-method)))
    (when verbose
      (format t "~&Evaluation: ~5,3f" score))
    score))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; subclasses and methods

(defclass classifier (trainable-object)
  ((classes :initarg :classes :type fixnum)))

(defclass binary-classifier (classifier)
  ((classes :type fixnum :initform 2)))

(defmethod initialize-instance :after ((m binary-classifier) &rest args &key &allow-other-keys)
  (with-slots (classes) m
    (assert (= classes 2))))




