import {
  IsString,
  IsEmail,
} from 'class-validator';

export class CreateMemberDto {

  @IsString()
  name: string;

  @IsEmail()
  email: string;

  @IsString()
  phone: string;

  @IsString()
  address: string;
}