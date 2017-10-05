class apt_update {
    exec { "aptGetUpdate":
        command => "sudo apt-get update",
        path => ["/bin", "/usr/bin"]
    }
}

class othertools {
    package { "git":
        ensure => latest,
        require => Exec["aptGetUpdate"]
    }

    package { "vim-common":
        ensure => latest,
        require => Exec["aptGetUpdate"]
    }

    package { "curl":
        ensure => present,
        require => Exec["aptGetUpdate"]
    }

    package { "htop":
        ensure => present,
        require => Exec["aptGetUpdate"]
    }

    package { "g++":
        ensure => present,
        require => Exec["aptGetUpdate"]
    }
}


class mongodbp {
  class {'::mongodb::globals':
    manage_package_repo => true,
    bind_ip             => ["127.0.0.1"],
  }->
  class {'::mongodb::server':
    port    => 27017,
    verbose => true,
    ensure  => "present"
  }->
  class {'::mongodb::client': }
  

}

  mongodb::db { 'testdb':
    user        => 'user1',
    password 	=> 'pass1',
  }
  
    mongodb::db { 'nodetest1':
    user        => 'user1',
    password 	=> 'pass1',
  }

class { '::nodejs':
  manage_package_repo       => true,
  nodejs_dev_package_ensure => 'present',
  npm_package_ensure        => 'present',
}

class node_packages{
	package { 'express':
	  ensure   => 'latest',
	  provider => 'npm',
	}

	package { 'express-generator':
	  ensure   => 'latest',
	  provider => 'npm',
	}
	
	package { 'nodemon':
	  ensure   => 'latest',
	  provider => 'npm',
	}
}

include apt_update
include othertools
include nodejs
include mongodbp
include node_packages


