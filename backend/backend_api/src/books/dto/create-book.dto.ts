import { IsString, IsNumber } from 'class-validator';

export class CreateBookDto {

  @IsString()
  title: string;

  @IsString()
  author: string;

  @IsString()
  publisher: string;

  @IsString()
  isbn: string;

  @IsNumber()
  stock: number;
}