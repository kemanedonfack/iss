<?php

    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "iai";
    $table = "etudiants";

    $action = $_POST["action"];

    // creation de la connexion a la base de données
    $conn = new mysqli($servername, $username, $password, $dbname);

    // verification de la connexion
    if($conn->connect_error){
        die("connexion échoué: ".$conn->connect_error);
        return;
    }

    // récupérer tous les employées de la base de données
    if("GET_ET_ACTION" == $action){
        $matricule = $_POST["matricule"];
        $db_data = array();

        $sql = "SELECT etudiants.nom, etudiants.photo, etudiants.matricule, etudiants.email, etudiants.telephone, etudiants.classe, etudiants.niveau,
        preinscriptions.paye AS preInscription, premieretranches.paye AS un, deuxiemetranches.paye AS deux, 
        troisiemetranches.paye AS trois, quatriemetranches.paye AS quatre, preinscriptions.datepayement AS preinscriptionDate,
        premieretranches.datepayement AS unDate, deuxiemetranches.datepayement AS deuxDate, troisiemetranches.datepayement AS troisDate,
        quatriemetranches.datepayement AS quatreDate, etudiants.preinscription_id AS idPreinscription, etudiants.premieretranche_id AS idPremiereTranche,
        etudiants.deuxiemetranche_id AS idDeuxiemeTranche, etudiants.trosiemetranche_id AS idTroisiemeTranche, etudiants.quatriemetranche_id AS idQuatriemeTranche        

        FROM etudiants 

        INNER JOIN preinscriptions
        ON etudiants.preinscription_id = preinscriptions.id

        INNER JOIN premieretranches
        ON etudiants.premieretranche_id = premieretranches.id

        INNER JOIN deuxiemetranches
        ON etudiants.deuxiemetranche_id = deuxiemetranches.id

        INNER JOIN troisiemetranches
        ON etudiants.trosiemetranche_id = troisiemetranches.id
        
        INNER JOIN quatriemetranches
        ON etudiants.trosiemetranche_id = quatriemetranches.id

        WHERE etudiants.matricule = '$matricule' ";
        
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

    // récupérer tous les employées de la base de données
    if("GET_ALL_ACTION" == $action){
        $db_data = array();
        $sql = "SELECT * FROM etudiants ORDER BY nom ASC";
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

    if("CONNEXION" == $action){
        $numero =  $_POST["numero"];
        $pass =  $_POST["pass"];
        $db_data = array();
        $sql = "SELECT * FROM administrateurs WHERE numero ='$numero' AND motdepasse='$pass' ";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
           echo "success";
        }else{
            echo "erreur";
        }
        $conn->close();
        return;
    }


