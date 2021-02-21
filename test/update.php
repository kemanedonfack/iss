<?php

    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "iai";

    $action = $_POST["action"];

    // creation de la connexion a la base de données
    $conn = new mysqli($servername, $username, $password, $dbname);

    // verification de la connexion
    if($conn->connect_error){
        die("connexion échoué: ".$conn->connect_error);
        return;
    }



    // modifier information de l'étudiant
    if("UPDATE_ET" == $action){
        
        // etudiant 
        $nom = $_POST["nom"];
        $matricule = $_POST["matricule"];
        $email = $_POST["email"];
        $telephone = $_POST["telephone"];
        $classe = $_POST["classe"];
        $niveau = $_POST["niveau"];

        $sql = "UPDATE etudiants SET nom = '$nom', email = '$email', telephone = '$telephone', classe = '$classe', niveau = '$niveau' WHERE matricule = '$matricule' ";

        // préinscription
        $idPreinscription = $_POST["idPreinscription"];
        $preinscriptionDate = $_POST["preinscriptionDate"];
        $PreinscriptionPaye = $_POST["PreinscriptionPaye"];

        $sql2 = "UPDATE preinscriptions SET datepayement = '$preinscriptionDate', paye = '$PreinscriptionPaye' WHERE id = '$idPreinscription' ";

        // $sql2 = "UPDATE preinscriptions SET datepayement = '$preinscriptionDate', paye = '$PreinscriptionPaye'  
        // WHERE id = '$idPreinscription'";

        // prémiere tranche
        $idPremiereTranche = $_POST["idPremiereTranche"];
        $premiereTrancheDate = $_POST["premiereTrancheDate"];
        $premiereTranchePaye = $_POST["premiereTranchePaye"];

        $sql3 = "UPDATE premieretranches SET datepayement = '$premiereTrancheDate', paye = '$premiereTranchePaye' WHERE id = '$idPremiereTranche' ";
        
        // deuxieme tranche
        $idDeuxiemeTranche = $_POST["idDeuxiemeTranche"];
        $deuxiemeTrancheDate = $_POST["deuxiemeTrancheDate"];
        $deuxiemeTranchePaye = $_POST["deuxiemeTranchePaye"];

        $sql4 = "UPDATE deuxiemetranches SET datepayement = '$deuxiemeTrancheDate', paye = '$deuxiemeTranchePaye' WHERE id = '$idDeuxiemeTranche' ";
        
        // troisieme tranche
        $idTroisiemeTranche = $_POST["idTroisiemeTranche"];
        $troisiemeTrancheDate = $_POST["troisiemeTrancheDate"];
        $troisiemeTranchePaye = $_POST["troisiemeTranchePaye"];

        $sql5 = "UPDATE troisiemetranches SET datepayement = '$troisiemeTrancheDate', paye = '$troisiemeTranchePaye' WHERE id = '$idTroisiemeTranche' ";

        
        // quatrieme tranche
        $idQuatriemeTranche = $_POST["idQuatriemeTranche"];
        $quatriemeTrancheDate = $_POST["quatriemeTrancheDate"];
        $quatriemeTranchePaye = $_POST["quatriemeTranchePaye"];
        
        $sql6 = "UPDATE quatriemetranches SET datepayement = '$quatriemeTrancheDate', paye = '$quatriemeTranchePaye' WHERE id = '$idQuatriemeTranche' ";


        // $sql = "UPDATE $table SET first_name = '$first_name', last_name = '$last_name' WHERE id = '$emp_id'";
        if( $conn->query($sql) === TRUE && $conn->query($sql2) === TRUE && $conn->query($sql3) === TRUE && $conn->query($sql4) === TRUE 
                && $conn->query($sql5) === TRUE && $conn->query($sql6) === TRUE  ){
            echo "success";
        }else{
            echo "erreur";
        }
        $conn->close();
        return;
    }







?>