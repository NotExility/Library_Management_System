import {
  Controller,
  Get,
  Post,
  Delete,
  Param,
  Body,
} from '@nestjs/common';

import { BorrowingsService } from './borrowings.service';
import { CreateBorrowingDto } from './dto/create-borrowing.dto';

@Controller('borrowings')
export class BorrowingsController {

  constructor(
    private readonly borrowingsService:
      BorrowingsService,
  ) {}

  @Post()
  create(
    @Body() dto: CreateBorrowingDto,
  ) {
    return this.borrowingsService.create(dto);
  }

  @Get()
  findAll() {
    return this.borrowingsService.findAll();
  }

  @Delete(':id')
  remove(
    @Param('id') id: string,
  ) {
    return this.borrowingsService.remove(+id);
  }
}