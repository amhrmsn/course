<?php
  include 'connection.php';
  $sql = "SELECT 
          u.email,
          u.fullname,
          u.photo,
          u.nrp,
          u.program,
          u.biografi
          FROM uas_contacts c
          JOIN uas_profile u
          ON u.email = 
          CASE 
            WHEN c.contact_request = ? 
            THEN c.contact_to
            ELSE c.contact_request
          END
          WHERE (c.contact_request = ? OR c.contact_to = ?) AND c.approve = 'APPROVED'";
  $stmt = $conn->prepare($sql);
  $stmt->bind_param("sss", $email, $email, $email);
  $stmt->execute();
  $result = $stmt->get_result();
  $data = [];
  while ($row = $result->fetch_assoc()) {
    $data[] = [
      "email"    => $row['email'],
      "fullname" => $row['fullname'],
      "photo"    => "images/" . htmlspecialchars($row['photo']),
      "nrp"      => $row['nrp'],
      "program"  => $row['program'],
      "biografi" => $row['biografi'],
    ];
  }
  echo json_encode([
    "result" => "success",
    "data"   => $data
  ]);
  $stmt->close();
  $conn->close();
?>