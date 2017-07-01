;;; Code:

(require 'thingatpt)

(defun me/docker-exec-bash ()
  "Run docker exec -it <container> bash."
  (interactive)
  (let ((name-or-id (thing-at-point 'word)))
    (message name-or-id)
    (async-shell-command
     (concat "docker exec -it " name-or-id " bash -l")
     (concat "* docker exec for " name-or-id)
     ))
  )

(defun me/docker-images ()
  "Run docker images."
  (interactive)
  (async-shell-command "docker images" "*docker images*"))

(defun me/docker-volumes ()
  "Run docker volumes."
  (interactive)
  (async-shell-command "docker volume ls" "*docker volumes*"))

(defun me/docker-volumes-dangling ()
  "Run docker volumes."
  (interactive)
  (async-shell-command "docker volume ls --filter dangling=true" "*docker volumes dangling*"))

(defun me/docker-port ()
  "Run docker port."
  (interactive)
  (let ((name-or-id (thing-at-point 'word)))
    (message name-or-id)
    (async-shell-command
     (concat "docker port " name-or-id)
     "* docker port*"
     ))
  )

(defun me/docker-inspect ()
  "Run docker port."
  (interactive)
  (let ((name-or-id (thing-at-point 'word)))
    (message name-or-id)
    (async-shell-command
     (concat "docker inspect " name-or-id)
     "* docker inspect*"
     ))
  )

(defun me/docker-ps ()
  "Run docker ps."
  (interactive)
  (async-shell-command "docker ps" "*docker ps*"))

(defun me/docker-psa ()
  "Run docker ps."
  (interactive)
  (async-shell-command "docker ps -a" "*docker ps -a*"))

(defun me/docker-rmi ()
  "Run docker rmi <image>."
  (interactive)
  (let ((image-name-or-id (thing-at-point 'word)))
    (message image-name-or-id)
    (async-shell-command
     (concat "docker rmi " image-name-or-id)
     "* docker rm*"
     )))

(defun me/docker-rm ()
  "Run docker rm <container>."
  (interactive)
  (let ((name-or-id (thing-at-point 'word)))
    (message name-or-id)
    (async-shell-command
     (concat "docker rm " name-or-id)
     "* docker rm*"
     )))

(defun me/docker-rmf ()
  "Run docker rm -f <container>."
  (interactive)
  (let ((name-or-id (thing-at-point 'word)))
    (message name-or-id)
    (async-shell-command
     (concat "docker rm -f " name-or-id)
     "* docker rm*"
     )))

(provide 'docker)
;;; docker.el ends here
