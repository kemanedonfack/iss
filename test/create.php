<?php

    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "iai";
    $table1 = "preinscriptions";
    $table2 = "premieretranches";
    $table3 = "deuxiemetranches";
    $table4 = "troisiemetranches";
    $table5 = "quatriemetranches";
    $table6 = "etudiants";
    $table7 = "administrateurs";

    $action = $_POST["action"];

    // creation de la connexion a la base de données
    $conn = new mysqli($servername, $username, $password, $dbname);

    // verification de la connexion
    if($conn->connect_error){
        die("connexion échoué: ".$conn->connect_error);
        return;
    }

    // si la connexion a la base de données est bonnne
  
    if("CREATE_TABLE" == $action){
        $sql1 = "CREATE TABLE IF NOT EXISTS $table1 (
            `id` INT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
            `datepayement` VARCHAR(255) NOT NULL ,
            `paye` VARCHAR(255) NOT NULL ,
            PRIMARY KEY (`id`)
            )";

        $sql2 = "CREATE TABLE IF NOT EXISTS $table2 (
            `id` INT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
            `datepayement` VARCHAR(255) NOT NULL ,
            `paye` VARCHAR(255) NOT NULL ,
            PRIMARY KEY (`id`)
            )";  
         $sql3 = "CREATE TABLE IF NOT EXISTS $table3 (
            `id` INT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
            `datepayement` VARCHAR(255) NOT NULL ,
            `paye` VARCHAR(255) NOT NULL ,
            PRIMARY KEY (`id`)
            )";

        $sql4 = "CREATE TABLE IF NOT EXISTS $table4 (
            `id` INT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
            `datepayement` VARCHAR(255) NOT NULL ,
            `paye` VARCHAR(255) NOT NULL ,
            PRIMARY KEY (`id`)
            )"; 

        $sql5 = "CREATE TABLE IF NOT EXISTS $table5 (
            `id` INT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
            `datepayement` VARCHAR(255) NOT NULL ,
            `paye` VARCHAR(255) NOT NULL ,
            PRIMARY KEY (`id`)
            )";
            
        $sql6 = "CREATE TABLE IF NOT EXISTS $table6 (
            `id` INT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
            `photo` VARCHAR(255) NOT NULL ,
            `nom` VARCHAR(255) NOT NULL ,
            `matricule` VARCHAR(255) NOT NULL ,
            `email` VARCHAR(255) NOT NULL ,
            `telephone` VARCHAR(255) NOT NULL ,
            `classe` VARCHAR(255) NOT NULL ,
            `niveau` VARCHAR(255) NOT NULL  ,
            `preinscription_id` INT(15) NOT NULL ,
            `premieretranche_id` INT(15) NOT NULL ,
            `deuxiemetranche_id` INT(15) NOT NULL ,
            `trosiemetranche_id` INT(15) NOT NULL ,
            `quatriemetranche_id` INT(15) NOT NULL ,
            -- CONSTRAINT fk_etudiant_preinscription
            -- FOREIGN KEY (preinscription_id) 
            -- REFERENCES preinscriptions(id),

            PRIMARY KEY (`id`)
            )";    

        $sql7 = "CREATE TABLE IF NOT EXISTS $table7 (
            `id` INT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
            `nom` VARCHAR(255) NOT NULL ,
            `email` VARCHAR(255) NOT NULL ,
            `numero` VARCHAR(255) NOT NULL ,
            `motdepasse` VARCHAR(255) NOT NULL,
            
            PRIMARY KEY (`id`)
            )"; 
        $nom = "admin";
        $email="admin@gmail.com";
        $numero="690710856";
        $motdepasse="15e2b0d3c33891ebb0f1ef609ec419420c20e320ce94c65fbc8c3312448eb225";
        $sql8 = "INSERT INTO administrateurs (nom, email, numero, motdepasse) 
                VALUES ('$nom', '$email','$numero','$motdepasse')";
            
        $conn->query($sql8);
        if($conn->query($sql1) === TRUE && $conn->query($sql2) === TRUE && 
            $conn->query($sql3) === TRUE && $conn->query($sql4) === TRUE &&
            $conn->query($sql5) === TRUE && $conn->query($sql6) === TRUE && $conn->query($sql7) === TRUE ){
            // message en cas de succès
            echo "success";
        }else{
            echo "erreur creation";
        }

        $conn->close();
        return;
    }

    // récupérer tous les employées de la base de données
    if("GET_ALL" == $action){
        $db_data = array();
        $sql = "SELECT * FROM $table ORDER BY id DESC";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }

            echo json_encode($db_data);
        }else{
            echo "erreur";
        }

        $conn->close();
        return;
    }

    // modifier information d'un employé
    if("UPDATE_EMP" == $action){

        $emp_id = $_POST['emp_id'];
        $datepayement = $_POST["datepayement"];
        $paye = $_POST["paye"];
        $sql = "UPDATE $table SET datepayement = '$datepayement', paye = '$paye' WHERE id = '$emp_id'";
        if($conn->query($sql) === TRUE ){
            echo "success";
        }else{
            echo "erreur";
        }
        $conn->close();
        return;
    }

        // supprimer un employé
    if("DELETE_EMP" == $action){
        $emp_id = $_POST['emp_id'];
        $sql = "DELETE FROM $table WHERE id = $emp_id";

        if($conn->query($sql) === TRUE ){
            echo "succès";
        }else{
            echo "erreur";
        }
        $conn->close();
        return;
    }






?>