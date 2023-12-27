echo "Conceptualization MVC2 Architecture - by finnwinch📎"
mkdir website
cd website
mkdir model
mkdir view
mkdir controller
mkdir script
mkdir content
touch index.php
echo '
<?php
	include_once "controller/manufacture.controller.php";
	if (isset($_GET["action"]) && $_GET["action"] != null) {
		$action = $_GET["action"] ;
	} else {
		$action = "" ;	
	}
	$controleur = ManufactureControleur::creerControleur($action) ;
	$vue = $controleur->executerAction() ;
	include_once("view/page/" . $vue . ".php") ;
?>
' > index.php
cd model
mkdir database
mkdir sql
mkdir class
cd class
touch demo.interface.php
echo '
<?php
    interface SchoolSkill{
        public function read() ;
		public function write() ;
    }
?>
' > demo.interface.php
touch demo.class.php
echo '
<?php
	include_once("demo.interface.php");
    class Question implements SchoolSkill {
        private string $nom ;
        private string $prenom ;
        public function __construct(string $nom, string $prenom) {
            $this->nom = $nom ;
            $this->prenom = $prenom ;
        }
        public function read() {
        }
        public function write() {
        }
    }
?>
' > demo.class.php
cd ..
cd database
touch table.sql
touch droptable.sql
touch connexionBD.class.php
echo '
<?php
    include_once("connexionBD.interface.php");
	class ConnexionBD implements ConfigBD  {	
        private static $instance=null;
		private function __construct() {}
		public static function getInstance() {
			 if (self::$instance==null) {
				$configuration="mysql:host=".ConfigBD::BD_HOTE.";dbname=".ConfigBD::BD_NOM;
				$utilisateur=ConfigBD::BD_UTILISATEUR;
				$motPasse=ConfigBD::BD_MOT_PASSE;
				self::$instance=new PDO($configuration,$utilisateur,$motPasse);	
				self::$instance->exec("SET character_set_results = 'utf8'");	
				self::$instance->exec("SET character_set_client = 'utf8'");	
				self::$instance->exec("SET character_set_connection = 'utf8'");	
		}
        return self::$instance;
		}
		public static function close() {
			self::$instance=null;
		}
	}
?>
' > connexionBD.class.php
touch connexionBD.interface.php
echo '
<?php
interface ConfigBD
{	
    const BD_HOTE = "localhost";
    const BD_UTILISATEUR = "root";
    const BD_MOT_PASSE = "root";
    const BD_NOM = "table_name";   
}
?>
' > connexionBD.interface.php
cd ..
cd sql
touch demo.dao.interface.php
echo '
<?php
    interface DemoDAOInterface{
        public static function functionA(string $parametreA, string $parametreB) ;
    }
?>
' > demo.dao.interface.php
touch demo.dao.class.php
echo '
<?php
    include_once("../connexionBD.class.php");
    include_once("demo.dao.interface.php") ;
    class DemoDAO implements DemoDAOInterface {
		public static function functionA(string $parametreA, string $parametreB){
			$connexion = ConnexionBD::getInstance();
			$requete = $connexion->prepare("query");
			$requete->execute();
			$result = $requete->fetchAll(PDO::FETCH_ASSOC);
            $requete->closeCursor();
            ConnexionBD::close();
            return $result ;
		}
	}
' > demo.dao.class.php
cd ..
cd ..
cd view
mkdir inc
mkdir page
cd ..
cd controller
touch base.abstract.controller.php
echo '
<?php
	abstract class Controleur {
		public function __construct() {}
		abstract public function executerAction();
	}
?>
' > base.abstract.controller.php
touch manufacture.controller.php
echo '
<?php
	include_once("default.controller.php") ;
	class ManufactureControleur {
		public static function creerControleur($action) {
			$constructeur = null ;
			switch($action) {
				default : $constructeur = new Demo() ; break ;
			}
			return $constructeur ;
		}
	}
?>
' > manufacture.controller.php
touch demo.controller.php
echo '
<?php
	include_once("base.abstract.controller.php") ;
	class Demo extends Controleur {
		public function __construct() {
			parent::__construct() ;
		}
		public function executerAction() {
			return "pageAccueil" ;
		}
	}	
?>
' > demo.controller.php
read -p "Conceptualization MVC2 Architecture Finished!" closed