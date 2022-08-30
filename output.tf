output "instance_id" {
    description = "ID das instancias"
    value = aws_instance.front_nidio-ec2.*.id
}

output "instance_public_ip" {
    description = "Ip publico"
    value = aws_instance.front_nidio-ec2.*.public_ip
}
output "instance_front_private_ip" {
    description = "Ip privado front"
    value = aws_instance.front_nidio-ec2.*.private_ip
}

output "instance_public_dns" {
    description = "DNS publico"
    value = aws_instance.front_nidio-ec2.*.public_dns
        
}

output "instance_private_ip" {
    description = "Ip privado"
    value = aws_instance.back_nidio-ec2.*.private_ip
}

output "instance_public_ip_mngt" {
    description = "Ip publico"
    value = aws_instance.mngt_nidio-ec2.*.public_ip
}