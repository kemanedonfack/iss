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


    // ajouter preinscription
    if("ADD_PI_ACTION" == $action){
        $datepayement = $_POST["datepayement"];
        $paye = $_POST["paye"];
        $sql = "INSERT INTO $table1 (datepayement, paye) VALUES ('$datepayement', '$paye')";
        $result = $conn->query($sql);
        $id = $conn->insert_id;
        echo $id;
        $conn->close();
        return;
    }

    // ajouter premiere tranche
    if("ADD_PT_ACTION" == $action){
        $datepayement = $_POST["datepayement"];
        $paye = $_POST["paye"];
        $sql = "INSERT INTO $table2 (datepayement, paye) VALUES ('$datepayement', '$paye')";
        $result = $conn->query($sql);
        $id = $conn->insert_id;
        echo $id;
        $conn->close();
        return;
    }

      // ajouter deuxieme tranche
      if("ADD_DT_ACTION" == $action){
        $datepayement = $_POST["datepayement"];
        $paye = $_POST["paye"];
        $sql = "INSERT INTO $table3 (datepayement, paye) VALUES ('$datepayement', '$paye')";
        $result = $conn->query($sql);
        $id = $conn->insert_id;
        echo $id;
        $conn->close();
        return;
    }

      // ajouter troisieme tranche
      if("ADD_TT_ACTION" == $action){
        $datepayement = $_POST["datepayement"];
        $paye = $_POST["paye"];
        $sql = "INSERT INTO $table4 (datepayement, paye) VALUES ('$datepayement', '$paye')";
        $result = $conn->query($sql);
        $id = $conn->insert_id;
        echo $id;
        $conn->close();
        return;
    }

      // ajouter quatrieme tranche
      if("ADD_QT_ACTION" == $action){
        $datepayement = $_POST["datepayement"];
        $paye = $_POST["paye"];
        $sql = "INSERT INTO $table5 (datepayement, paye) VALUES ('$datepayement', '$paye')";
        $result = $conn->query($sql);
        $id = $conn->insert_id;
        echo $id;
        $conn->close();
        return;
    }


    //   ajouter etudiant
      if("ADD_ET_ACTION" == $action){
        $sql1 = "SELECT * FROM $table1";
        $preinscription_id = $conn->query($sql1)->num_rows;
        
        $sql2 = "SELECT * FROM $table2";
        $premieretranche_id = $conn->query($sql2)->num_rows;
        
        $sql3 = "SELECT * FROM $table3";
        $deuxiemetranche_id = $conn->query($sql3)->num_rows;
        
        $sql4 = "SELECT * FROM $table4";
        $trosiemetranche_id = $conn->query($sql4)->num_rows;
        
        $sql5 = "SELECT * FROM $table5";
        $quatriemetranche_id = $conn->query($sql5)->num_rows;
        
        $photo = $_POST["photo"];
        $nom = $_POST["nom"];
        $matricule = $_POST["matricule"];
        $email = $_POST["email"];
        $telephone = $_POST["telephone"];
        $classe = $_POST["classe"];
        $niveau = $_POST["niveau"];
        // if($niveau == 3){
        //   $quatriemetranche_id = $conn->query($sql5)->num_rows;
        // }else{
        //   $quatriemetranche_id = 0;
        // }
        $sql = "INSERT INTO $table6 (photo, nom, matricule, email, telephone, classe, niveau, 
        preinscription_id, premieretranche_id, deuxiemetranche_id, trosiemetranche_id, quatriemetranche_id ) 
        VALUES ('$photo', '$nom', '$matricule', '$email', '$telephone', '$classe', '$niveau', '$preinscription_id', 
        '$premieretranche_id', '$deuxiemetranche_id', '$trosiemetranche_id', '$quatriemetranche_id')";
        $result = $conn->query($sql);
        $id = $conn->insert_id;
        echo $id;
        $conn->close();
        return;
    }








